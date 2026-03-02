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
region     = attribute('region')

expected_instances = 4
expected_instance_groups = 1

control "MIG" do
  title "Simple Configuration"

  # 1. Instance Verification (Using Strongly Consistent Zonal Query)
  # We use '--zones' instead of '--regions' because 'instances list' is a zonal command.
  # For the standard 'us-central1' test, we check all 4 possible zones.
  describe command("gcloud compute instances list --project=#{project_id} --zones=#{region}-a,#{region}-b,#{region}-c,#{region}-f --format=json --filter='name:mig-simple'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' } # Will be empty because data is found immediately

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        []
      end
    end

    describe "number of instances" do
      it "should be #{expected_instances}" do
        expect(data.length).to eq(expected_instances)
      end
    end
  end

  # 2. Instance Group Verification (Regional Query - Supported and Reliable)
  describe command("gcloud compute instance-groups list --project=#{project_id} --regions=#{region} --format=json --filter='name:mig-simple'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        []
      end
    end

    describe "number of instance groups" do
      it "should be #{expected_instance_groups}" do
        expect(data.length).to eq(expected_instance_groups)
      end
    end
  end

  # 3. Managed Instance Group Verification (Regional Query - Supported and Reliable)
  describe command("gcloud compute instance-groups managed list --project=#{project_id} --regions=#{region} --format=json --filter='name:mig-simple'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        []
      end
    end

    describe "number of managed instance groups" do
      it "should be #{expected_instance_groups}" do
        expect(data.length).to eq(expected_instance_groups)
      end
    end
  end
end
