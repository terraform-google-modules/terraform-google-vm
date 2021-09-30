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
	const zone_ins_1 = "us-central1-a"
	const zone_ins_2 = "us-central1-b"
	const zone_ins_3 = "us-central1-c"
	const zone_ins_4 = "us-central1-f"

	insSimpleT := tft.NewTFBlueprintTest(t)
	insSimpleT.DefineVerify(func(assert *assert.Assertions) {
		insSimpleT.DefaultVerify(assert)

		op := gcloud.Run(t, fmt.Sprintf("compute instances list --project %s --filter name~%s", insSimpleT.GetStringOutput("project_id"), instanceNameApprox))

		instances := op.Array()
		assert.Equal(expected_instances, len(instances), "found 4 gce instances")
		assert.Contains(instances[0].Get("zone").String(), zone_ins_1, "instance 001 is in the right zone")
		assert.Contains(instances[1].Get("zone").String(), zone_ins_2, "instance 002 is in the right zone")
		assert.Contains(instances[2].Get("zone").String(), zone_ins_3, "instance 003 is in the right zone")
		assert.Contains(instances[3].Get("zone").String(), zone_ins_4, "instance 004 is in the right zone")
	})
	insSimpleT.Test()
}
