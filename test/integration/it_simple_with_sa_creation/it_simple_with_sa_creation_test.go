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
	const expectedTemplates = 1
	const expectedServiceAccounts = 1

	instanceSimpleTest := tft.NewTFBlueprintTest(t)
	instanceSimpleTest.DefineVerify(func(assert *assert.Assertions) {
		instanceSimpleTest.DefaultVerify(assert)

		projectID := instanceSimpleTest.GetStringOutput("project_id")
		instanceTemplates := gcloud.Run(t, fmt.Sprintf("compute instance-templates list --project %s --filter name~%s", projectID, instanceNamePrefix))
		assert.Equal(expectedTemplates, len(instanceTemplates.Array()), fmt.Sprintf("should have %d instance templates", expectedTemplates))

		serviceAccounts := gcloud.Run(t, fmt.Sprintf("iam service-accounts list --project %s --filter email~%s", projectID, instanceNamePrefix))
		assert.Equal(expectedServiceAccounts, len(serviceAccounts.Array()), fmt.Sprintf("should have %d service accounts", expectedServiceAccounts))

		for _, it := range instanceTemplates.Array() {
			instanceTemplateName := it.Get("name").String()
			instanceTemplateServiceAccounts := gcloud.Run(t, fmt.Sprintf("compute instance-templates describe %s --project %s", instanceTemplateName, projectID), gcloud.WithCommonArgs([]string{"--format", "json(properties.serviceAccounts)"}))
			assert.Contains(instanceTemplateServiceAccounts.String(), instanceNamePrefix, fmt.Sprintf("Instance template service account %s should contain %s", instanceTemplateServiceAccounts.String(), instanceNamePrefix))
		}
	})
	instanceSimpleTest.Test()
}
