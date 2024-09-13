// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package confidential_instance_template

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestConfidentialComputeInstance(t *testing.T) {
	const instanceNamePrefix = "confidential-encrypted-instance"

	confCompInst := tft.NewTFBlueprintTest(t)
	confCompInst.DefineVerify(func(assert *assert.Assertions) {
		confCompInst.DefaultVerify(assert)
		projectId := confCompInst.GetStringOutput("project_id")

		computeInstanceList := gcloud.Run(t, fmt.Sprintf("compute instances list --format=json --project %s --filter name~%s", projectId, instanceNamePrefix))

		assert.Len(computeInstanceList.Array(), 1)
		computeInstance := computeInstanceList.Array()[0]
		confidentialInstanceConfig := computeInstance.Get("confidentialInstanceConfig")
		assert.True(confidentialInstanceConfig.Get("enableConfidentialCompute").Bool())
		assert.Equal("SEV", confidentialInstanceConfig.Get("confidentialInstanceType").String())
		assert.Equal("MIGRATE", computeInstance.Get("scheduling").Get("onHostMaintenance").String())
		serviceAccounts := computeInstance.Get("serviceAccounts").Array()
		assert.Len(serviceAccounts, 1)
		assert.Equal(fmt.Sprintf("confidential-compute-sa@%s.iam.gserviceaccount.com", projectId), serviceAccounts[0].Get("email").String())
		serviceAccountBindings := gcloud.Runf(t, "projects get-iam-policy %s --flatten bindings --filter bindings.members:'serviceAccount:%s' --format json", projectId, serviceAccounts[0].Get("email").String()).Array()
		assert.Equal(2, len(serviceAccountBindings), "expect two bindings")
		assert.ElementsMatch([]string{"roles/compute.imageUser", "roles/compute.networkUser"}, []string{serviceAccountBindings[0].Get("bindings.role").String(), serviceAccountBindings[1].Get("bindings.role").String()})
		disks := computeInstance.Get("disks").Array()
		assert.Len(disks, 1)
		defaultSuffix := confCompInst.GetStringOutput("suffix")
		assert.Equal(fmt.Sprintf("projects/%s/locations/us/keyRings/key-ring-test-%s/cryptoKeys/key-test-%s/cryptoKeyVersions/1", projectId, defaultSuffix, defaultSuffix), disks[0].Get("diskEncryptionKey").Get("kmsKeyName").String())

		org_policy_cmek_constraint := gcloud.Runf(t, "resource-manager org-policies list --project=%s --format=json --filter constraint='constraints/gcp.restrictNonCmekServices'", projectId).Array()
		assert.Len(org_policy_cmek_constraint, 1)
		cmek_denied_values_list := org_policy_cmek_constraint[0].Get("listPolicy.deniedValues").Array()
		assert.Len(cmek_denied_values_list, 1)
		assert.Equal("compute.googleapis.com", cmek_denied_values_list[0].String())
		org_policy_cmek_projects := gcloud.Runf(t, "resource-manager org-policies list --project=%s --format=json --filter constraint='constraints/gcp.restrictCmekCryptoKeyProjects'", projectId).Array()
		assert.Len(org_policy_cmek_projects, 1)
		cmek_allowed_projects := org_policy_cmek_projects[0].Get("listPolicy.allowedValues").Array()
		assert.Len(cmek_allowed_projects, 1)
		assert.Equal(fmt.Sprintf("projects/%s", projectId), cmek_allowed_projects[0].String())
		org_policy_confidential_constraint := gcloud.Runf(t, "resource-manager org-policies list --project=%s --format=json --filter constraint='constraints/compute.restrictNonConfidentialComputing'", projectId).Array()
		assert.Len(org_policy_confidential_constraint, 1)
		cc_denied_values_list := org_policy_confidential_constraint[0].Get("listPolicy.deniedValues").Array()
		assert.Len(cc_denied_values_list, 1)
		assert.Equal("compute.googleapis.com", cc_denied_values_list[0].String())
	})
	confCompInst.Test()
}
