# Copyright 2024 Google LLC
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

mig_name = "mig-lifecycle-policy"
expected_instance_groups = 1

control "MIG with instance_lifecycle_policy" do
  title "Verify MIG instance_lifecycle_policy is set to DO_NOTHING"

  # 1. Verify the MIG exists
  describe command("gcloud compute instance-groups managed list --project=#{project_id} --regions=#{region} --format=json --filter='name:#{mig_name}'") do
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

  # 2. Verify instance_lifecycle_policy.defaultActionOnFailure is DO_NOTHING
  describe command("gcloud compute instance-groups managed describe #{mig_name} --project=#{project_id} --region=#{region} --format=json") do
    its(:exit_status) { should eq 0 }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "instanceLifecyclePolicy.defaultActionOnFailure" do
      it "should be DO_NOTHING" do
        policy = data.dig("instanceLifecyclePolicy", "defaultActionOnFailure")
        expect(policy).to eq("DO_NOTHING")
      end
    end

    describe "instanceLifecyclePolicy.onFailedHealthCheck" do
      it "should be DO_NOTHING" do
        policy = data.dig("instanceLifecyclePolicy", "onFailedHealthCheck")
        expect(policy).to eq("DO_NOTHING")
      end
    end
  end
end
