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

package confidential_gpu

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestConfidentialGpu(t *testing.T) {
	const instanceNamePrefix = "confidential-gpu-instance"

	confCompInst := tft.NewTFBlueprintTest(t)
	confCompInst.DefineVerify(func(assert *assert.Assertions) {
		confCompInst.DefaultVerify(assert)
		projectId := confCompInst.GetStringOutput("project_id")

		computeInstanceList := gcloud.Run(t, fmt.Sprintf("compute instances list --format=json --project %s --filter name~%s", projectId, instanceNamePrefix))

		assert.Len(computeInstanceList.Array(), 1)
		computeInstance := computeInstanceList.Array()[0]
		confidentialInstanceConfig := computeInstance.Get("confidentialInstanceConfig")
		assert.True(confidentialInstanceConfig.Get("enableConfidentialCompute").Bool())
		assert.Equal("TDX", confidentialInstanceConfig.Get("confidentialInstanceType").String())
		assert.Equal("TERMINATE", computeInstance.Get("scheduling").Get("onHostMaintenance").String())
		serviceAccounts := computeInstance.Get("serviceAccounts").Array()
		assert.Len(serviceAccounts, 1)
		assert.Equal(fmt.Sprintf("confidential-gpu-sa@%s.iam.gserviceaccount.com", projectId), serviceAccounts[0].Get("email").String())
		serviceAccountBindings := gcloud.Runf(t, "projects get-iam-policy %s --flatten bindings --filter bindings.members:'serviceAccount:%s' --format json", projectId, serviceAccounts[0].Get("email").String()).Array()
		assert.Equal(2, len(serviceAccountBindings), "expect two bindings")
		assert.ElementsMatch([]string{"roles/compute.imageUser", "roles/compute.networkUser"}, []string{serviceAccountBindings[0].Get("bindings.role").String(), serviceAccountBindings[1].Get("bindings.role").String()})
		disks := computeInstance.Get("disks").Array()
		assert.Len(disks, 3)
		defaultSuffix := confCompInst.GetStringOutput("suffix")
		assert.Equal(fmt.Sprintf("projects/%s/locations/us/keyRings/key-ring-test-%s/cryptoKeys/key-test-%s/cryptoKeyVersions/1", projectId, defaultSuffix, defaultSuffix), disks[0].Get("diskEncryptionKey").Get("kmsKeyName").String())

		instanceName := computeInstance.Get("name").String()
		fullZoneName := strings.Split(computeInstance.Get("zone").String(), "/")
		zone := fullZoneName[len(fullZoneName)-1]

		for count := 0; count < 100; count++ {
			command := fmt.Sprintf("compute ssh %s --project %s --zone %s -q --command='journalctl -u google-startup-scripts.service -n 20'", instanceName, projectId, zone)
			logs, err := gcloud.RunCmdE(t, command)
			if err != nil {
				errorMsg := err.Error()
				println("ERROR: Unable to retrieve logs from the instance. Retrying...", errorMsg)
				time.Sleep(20 * time.Second)
				continue
			}

			if strings.Contains(logs, "startup-script: Confidential GPU activation script has completed successfully.") {
				if strings.Contains(logs, "startup-script exit status 1") {
					t.Fatal("ERROR: Startup Script finished with invalid exit status.")
				}
				break
			}

			if count == 99 {
				t.Fatal("ERROR: Startup Script did not complete successfully within the expected time frame.")
			}

			time.Sleep(12 * time.Second)
		}
		ccStatusLogs := gcloud.RunCmd(t, fmt.Sprintf("compute ssh %s --project %s --zone %s -q --command='sudo nvidia-smi conf-compute -f'", instanceName, projectId, zone))
		assert.Contains(ccStatusLogs, "CC status: ON")
		ccStateLogs := gcloud.RunCmd(t, fmt.Sprintf("compute ssh %s --project %s --zone %s -q --command='sudo nvidia-smi conf-compute -grs'", instanceName, projectId, zone))
		assert.Contains(ccStateLogs, "Confidential Compute GPUs Ready state: ready")
	})
	confCompInst.Test()
}
