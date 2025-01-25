// Copyright 2025 Google LLC
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

package it_simple_with_sa_creation

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestInstanceTemplateSimpleSAModule(t *testing.T) {

	const instanceNamePrefix = "it-simple-sa"
	const expected_templates = 1

	insSimpleT := tft.NewTFBlueprintTest(t)
	insSimpleT.DefineVerify(func(assert *assert.Assertions) {
		insSimpleT.DefaultVerify(assert)

		instance_templates := gcloud.Run(t, fmt.Sprintf("compute instance-templates list --project %s --filter name~%s", insSimpleT.GetStringOutput("project_id"), instanceNamePrefix))
		assert.Equal(expected_templates, len(instance_templates.Array()), fmt.Sprintf("should have %d instance_templates", expected_templates))
	})
	insSimpleT.Test()
}
