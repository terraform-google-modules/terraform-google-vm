# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id = attribute('project_id')
credentials_path = attribute('credentials_path')
region     = attribute('region')

ENV['CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE'] = credentials_path

# this main control block is referenced in the .kitchen.yml file. All tests fall within it.
control "umig_simple" do
  title "UMIG simple configuration"
  
  # A dead simple test to determine the number of RUNNING hosts that match our naming scheme

  instances_list = JSON.parse(`gcloud compute instances list --project=#{project_id} --filter="name:( default-* ) status:( RUNNING )" --format json`)
  # puts instance_list
  instances_list_length = instances_list.length
  describe instances_list_length do
    expected_length = 3
    it "instances found RUNNING. Expected to find #{expected_length}." do
      expect(instances_list_length).to eq(expected_length)
    end
  end
end
