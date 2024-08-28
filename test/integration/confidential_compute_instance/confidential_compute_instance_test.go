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

func TestConfidentialInstanceTemplate(t *testing.T) {
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
		disks := computeInstance.Get("disks").Array()
		assert.Len(disks, 1)
		defaultSuffix := confCompInst.GetStringOutput("suffix")
		assert.Equal(fmt.Sprintf("projects/%s/locations/us/keyRings/key-ring-test-%s/cryptoKeys/key-test-%s/cryptoKeyVersions/1", projectId, defaultSuffix, defaultSuffix), disks[0].Get("diskEncryptionKey").Get("kmsKeyName").String())
	})
	confCompInst.Test()
}
