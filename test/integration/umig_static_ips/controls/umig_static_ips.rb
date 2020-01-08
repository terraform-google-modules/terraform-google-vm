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
  title "Static IPs"

  describe command("gcloud --project=#{project_id} compute instances list --format=json --filter='name~^umig-static-ips*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

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

    describe "instance 001" do
      let(:instance) do
        data.find { |i| i['name'] == "umig-static-ips-001" }
      end

      it "should be in zone us-central1-a}" do
        expect(instance['zone']).to match(/.*us-central1-a$/)
      end

      it "should have IP 10.128.0.10}" do
        expect(instance['networkInterfaces'][0]['networkIP']).to eq("10.128.0.10")
      end
    end

    describe "instance 002" do
      let(:instance) do
        data.find { |i| i['name'] == "umig-static-ips-002" }
      end

      it "should be in zone us-central1-b}" do
        expect(instance['zone']).to match(/.*us-central1-b$/)
      end

      it "should have IP 10.128.0.11}" do
        expect(instance['networkInterfaces'][0]['networkIP']).to eq("10.128.0.11")
      end
    end

    describe "instance 003" do
      let(:instance) do
        data.find { |i| i['name'] == "umig-static-ips-003" }
      end

      it "should be in zone us-central1-c}" do
        expect(instance['zone']).to match(/.*us-central1-c$/)
      end

      it "should have IP 10.128.0.12}" do
        expect(instance['networkInterfaces'][0]['networkIP']).to eq("10.128.0.12")
      end
    end

    describe "instance 004" do
      let(:instance) do
        data.find { |i| i['name'] == "umig-static-ips-004" }
      end

      it "should be in zone us-central1-f}" do
        expect(instance['zone']).to match(/.*us-central1-f$/)
      end

      it "should have IP 10.128.0.13}" do
        expect(instance['networkInterfaces'][0]['networkIP']).to eq("10.128.0.13")
      end
    end
  end
end
