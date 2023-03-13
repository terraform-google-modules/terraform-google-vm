// Copyright 2021 Google LLC
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

	expected_instance_groups := 1
	expected_instances := 3

	migStatefulT := tft.NewTFBlueprintTest(t)
	migStatefulT.DefineVerify(func(assert *assert.Assertions) {
		migStatefulT.DefaultVerify(assert)

		instances := gcloud.Run(t, fmt.Sprintf("compute instances list --project %s --filter name~%s", migStatefulT.GetStringOutput("project_id"), instanceGroupNamePrefix))
		assert.Equal(expected_instances, len(instances.Array()), fmt.Sprintf("found %d gce instances", expected_instances))

		instanceGroups := gcloud.Run(t, fmt.Sprintf("compute instance-groups list --project %s --filter name~%s", migStatefulT.GetStringOutput("project_id"), instanceGroupNamePrefix))
		assert.Equal(expected_instance_groups, len(instanceGroups.Array()), fmt.Sprintf("found %d gce instance group", expected_instance_groups))

		managedInstanceGroups := gcloud.Run(t, fmt.Sprintf("compute instance-groups managed list --project %s --filter name~%s", migStatefulT.GetStringOutput("project_id"), instanceGroupNamePrefix))
		assert.Equal(expected_instance_groups, len(managedInstanceGroups.Array()), fmt.Sprintf("found %d gce managed instance group", expected_instance_groups))
		for _, mig := range managedInstanceGroups.Array() {
			assert.Equal(true, mig.Get("status").Get("stateful").Get("hasStatefulConfig").Bool(), fmt.Sprintf("%s has stateful config", mig.Get("name").String()))
		}

	})
	migStatefulT.Test()
}
