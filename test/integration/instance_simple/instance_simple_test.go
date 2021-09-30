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

package instance_simple

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestInstanceSimpleModule(t *testing.T) {

	const instanceNameApprox = `instance-simple`
	const expected_instances = 4
	zone_ins := []string{"us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"}

	insSimpleT := tft.NewTFBlueprintTest(t)
	insSimpleT.DefineVerify(func(assert *assert.Assertions) {
		insSimpleT.DefaultVerify(assert)

		op := gcloud.Run(t, fmt.Sprintf("compute instances list --project %s --filter name~%s", insSimpleT.GetStringOutput("project_id"), instanceNameApprox))

		instances := op.Array()
		assert.Equal(expected_instances, len(instances), "found 4 gce instances")

		for i, instance := range instances {
			assert.Contains(instance.Get("zone").String(), zone_ins[i], fmt.Sprintf("instance 00%d is in the right zone", i+1))
		}
	})
	insSimpleT.Test()
}
