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

ENV['CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE'] = File.absolute_path(
  credentials_path,
  File.join(__dir__, "../../../fixtures/vm/autoscaler"))

expected_instances = 4
expected_instance_groups = 1

control "VM" do
  title "Autoscaling Configuration"

  describe command("gcloud --project=#{project_id} compute instances list --format=json --filter='name~vm-autoscaler*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "number of instances" do
      it "should be #{expected_instances}" do
        expect(data.length).to eq(expected_instances)
      end
    end

    describe "network tags" do
      it "should include 'foo' and 'bar'" do
        data.each do |instance|
          expect(instance['tags']['items']).to include("foo")
          expect(instance['tags']['items']).to include("bar")
        end
      end
    end

    describe "labels" do
      it "should include 'environment' key" do
        data.each do |instance|
          expect(instance['labels']).to include("environment")
        end
      end
    end

    describe "labels" do
      it "'environment' should have value 'dev'" do
        data.each do |instance|
          expect(instance['labels']['environment']).to eq("dev")
        end
      end
    end

  end

  describe command("gcloud --project=#{project_id} compute instance-groups list --format=json --filter='name~vm-autoscaler*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "number of instance groups" do
      it "should be #{expected_instance_groups}" do
        expect(data.length).to eq(expected_instance_groups)
      end
    end
  end

  describe command("gcloud --project=#{project_id} compute instance-groups managed list --format=json --filter='name~vm-autoscaler*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "number of instance groups" do
      it "should be #{expected_instance_groups}" do
        expect(data.length).to eq(expected_instance_groups)
      end
    end

    describe "autoscaled" do
      it "should be yes" do
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
