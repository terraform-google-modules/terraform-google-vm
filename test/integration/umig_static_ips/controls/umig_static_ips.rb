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
available_zones = attribute('available_zones')
static_ips = attribute('static_ips')

ENV['CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE'] = File.absolute_path(
  credentials_path,
  File.join(__dir__, "../../../fixtures/umig/umig_static_ips"))

expected_instances = static_ips.length
expected_instance_groups = [available_zones.length, static_ips.length].min

control "UMIG" do
  title "Static IPs"

  describe command("gcloud --project=#{project_id} compute instances list --format=json --filter='name~^umig-static-ips*'") do
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

    (0...expected_instances).each do |idx|
      describe "instance 00#{idx+1}" do
        let(:instance) do
          data.find { |i| i['name'] == "umig-static-ips-00#{idx+1}" }
        end
        
        it "should be in zone #{available_zones[idx%available_zones.length]}" do
          expect(instance['zone']).to match(/^(.*)#{available_zones[idx%available_zones.length]}$/)
        end

        it "should have IP #{static_ips[idx]}" do
          expect(instance['networkInterfaces'][0]['networkIP']).to eq(static_ips[idx])
        end
      end
    end
  end

  describe command("gcloud --project=#{project_id} compute instance-groups list --format=json --filter='name~^umig-static-ips*'") do
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

    (0...expected_instance_groups).each do |idx|
      describe "instance group 00#{idx+1}" do
        let(:instance_group) do
          data.find { |i| i['name'] == "umig-static-ips-instance-group-00#{idx+1}" }
        end
        
        it "should be in zone #{available_zones[idx]}" do
          expect(instance_group['zone']).to match(/^(.*)#{available_zones[idx]}$/)
        end
        
        # This should work for any combination of number of instances and region/zones
        base_size = expected_instances/available_zones.length
        additional_instance = (expected_instances % available_zones.length > idx) ? 1 : 0
        it "should have size #{base_size + additional_instance}" do
          expect(instance_group['size']).to eq(base_size + additional_instance)
        end
      end
    end
  end
end
