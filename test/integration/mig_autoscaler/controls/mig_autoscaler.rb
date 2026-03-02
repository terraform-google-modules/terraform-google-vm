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
  title "Autoscaling Configuration"

  # 1. Instance Verification (Using Strongly Consistent Zonal Query)
  # We specify the zones to bypass the global aggregation lag.
  describe command("gcloud --project=#{project_id} compute instances list --zones=#{region}-a,#{region}-b,#{region}-c,#{region}-f --format=json --filter='name:mig-autoscaler'") do
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

  # 2. Instance Group Verification (Using Strongly Consistent Regional Query)
  describe command("gcloud --project=#{project_id} compute instance-groups list --regions=#{region} --format=json --filter='name:mig-autoscaler'") do
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

  # 3. Managed Instance Group & Autoscaler Verification (Regional Query)
  describe command("gcloud --project=#{project_id} compute instance-groups managed list --regions=#{region} --format=json --filter='name:mig-autoscaler'") do
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

    describe "autoscaling" do
      it "should be enabled" do
        expect(data[0]['autoscaled']).to eq("yes")
      end
    end

    describe "autoscaler scaling policy" do
      it "minNumReplicas should be 4" do
        expect(data[0]['autoscaler']['autoscalingPolicy']['minNumReplicas']).to eq(4)
      end
    end

    describe "autoscaler scaling policy" do
      it "cpuUtilization target should be 0.6" do
        expect(data[0]['autoscaler']['autoscalingPolicy']['cpuUtilization']['utilizationTarget']).to eq(0.6)
      end
    end
  end
end
