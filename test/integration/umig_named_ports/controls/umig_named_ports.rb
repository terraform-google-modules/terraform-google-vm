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

expected_instances = 4
expected_instance_groups = 4

control "UMIG" do
  title "With named ports"

  describe command("gcloud --project=#{project_id} compute instance-groups list --format=json --filter='name~^umig-named-ports*'") do
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

    describe "instance group 001" do
      let(:instance_group) do
        data.find { |i| i['name'] == "umig-named-ports-instance-group-001" }
      end

      it "should have 2 named ports" do
        expect(instance_group['namedPorts'].length).to eq(2)
      end
    end

    describe "instance group 002" do
      let(:instance_group) do
        data.find { |i| i['name'] == "umig-named-ports-instance-group-002" }
      end

      it "should have 2 named ports" do
        expect(instance_group['namedPorts'].length).to eq(2)
      end
    end

    describe "instance group 003" do
      let(:instance_group) do
        data.find { |i| i['name'] == "umig-named-ports-instance-group-003" }
      end

      it "should have 2 named ports" do
        expect(instance_group['namedPorts'].length).to eq(2)
      end
    end

    describe "instance group 004" do
      let(:instance_group) do
        data.find { |i| i['name'] == "umig-named-ports-instance-group-004" }
      end

      it "should have 2 named ports" do
        expect(instance_group['namedPorts'].length).to eq(2)
      end
    end
  end
end
