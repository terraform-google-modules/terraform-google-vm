/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package mig_stateful

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestMigStatefulModule(t *testing.T) {

	const instanceGroupNamePrefix = "mig-stateful"
	expected_instances := 3

	migStatefulT := tft.NewTFBlueprintTest(t)
	migStatefulT.DefineVerify(func(assert *assert.Assertions) {
		migStatefulT.DefaultVerify(assert)

		projectID := migStatefulT.GetStringOutput("project_id")
		region := migStatefulT.GetStringOutput("region")
		// Based on the Terraform apply logs, the actual resource name is 'mig-stateful-mig'
		migName := fmt.Sprintf("%s-mig", instanceGroupNamePrefix)

		// 1. Verify Managed Instance Group using a REGIONAL query (Strongly Consistent)
		// Specifying the region bypasses the stale global aggregated list index and ensures
		// the resource is found immediately after creation.
		mig := gcloud.Run(t, fmt.Sprintf("compute instance-groups managed describe %s --region %s --project %s", migName, region, projectID))

		// Verify the MIG exists and its target size matches expectations
		assert.Equal(int64(expected_instances), mig.Get("targetSize").Int(), "MIG should have the correct target size")

		// Verify stateful configuration status using the path from your original code
		assert.True(mig.Get("status").Get("stateful").Get("hasStatefulConfig").Bool(), fmt.Sprintf("%s should have stateful config", migName))

		// 2. Verify Instances using the regional MIG list-instances command (Strongly Consistent)
		// This queries the regional control plane directly for instances belonging to this specific MIG.
		instances := gcloud.Run(t, fmt.Sprintf("compute instance-groups managed list-instances %s --region %s --project %s", migName, region, projectID))
		assert.Equal(expected_instances, len(instances.Array()), fmt.Sprintf("expected to find %d instances in the MIG", expected_instances))
	})
	migStatefulT.Test()
}
