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

package confidential_simple

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestInstanceSimpleModule(t *testing.T) {

	const instanceNamePrefix = "confidential-simple"
	zoneIns := map[string]string{
		"confidential-simple-001": "us-central1-a",
		"confidential-simple-002": "us-central1-b",
		"confidential-simple-003": "us-central1-c",
	}

	insSimpleT := tft.NewTFBlueprintTest(t)
	insSimpleT.DefineVerify(func(assert *assert.Assertions) {
		insSimpleT.DefaultVerify(assert)

		instances := gcloud.Run(t, fmt.Sprintf("compute instances list --project %s --filter name~%s", insSimpleT.GetStringOutput("project_id"), instanceNamePrefix))
		assert.Equal(len(zoneIns), len(instances.Array()), "found 4 gce instances")

		for _, instance := range instances.Array() {
			instanceName := instance.Get("name").String()
			assert.Contains(instance.Get("zone").String(), zoneIns[instanceName], fmt.Sprintf("%s is in the right zone", instanceName))
			confidentialInstanceConfig := instance.Get("confidentialInstanceConfig")
			assert.True(confidentialInstanceConfig.Get("enableConfidentialCompute").Bool(), fmt.Sprintf("%s has confidential computing enabled", instanceName))
			assert.Equal(confidentialInstanceConfig.Get("confidentialInstanceType").String(), "SEV_SNP")
		}
	})
	insSimpleT.Test()
}
