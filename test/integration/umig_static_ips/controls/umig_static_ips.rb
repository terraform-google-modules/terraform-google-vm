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

control "UMIG" do
  title "Static IPs"

  # 1. Properly handle the attribute with a robust fallback for local testing
  project_id = attribute('project_id')
  raw_region = attribute('region')

  # Logic to ignore the InSpec "Input does not have a value" error string
  if raw_region.nil? || raw_region.include?("does not have a value")
    region = 'us-central1'
  else
    region = raw_region
  end

  # Map of instances and their expected properties
  instances_to_verify = {
    "umig-static-ips-001" => { zone: "a", ip: "10.128.0.10" },
    "umig-static-ips-002" => { zone: "b", ip: "10.128.0.11" },
    "umig-static-ips-003" => { zone: "c", ip: "10.128.0.12" },
    "umig-static-ips-004" => { zone: "f", ip: "10.128.0.13" }
  }

  # 2. Individual Instance and Static IP Verification (Strongly Consistent)
  instances_to_verify.each do |name, props|
    describe "Instance #{name}" do
      # Query the specific zone directly
      let(:cmd) { command("gcloud compute instances describe #{name} --zone=#{region}-#{props[:zone]} --project=#{project_id} --format=json") }

      it "should exist and be in RUNNING state" do
        expect(cmd.exit_status).to eq 0
        expect(JSON.parse(cmd.stdout)['status']).to eq "RUNNING"
      end

      it "should have the correct static IP #{props[:ip]}" do
        data = JSON.parse(cmd.stdout)
        expect(data['networkInterfaces'][0]['networkIP']).to eq props[:ip]
      end
    end
  end

  # 3. Instance Group Verification (Using Strongly Consistent Zonal Query)
  test_zones = "#{region}-a,#{region}-b,#{region}-c,#{region}-f"
  describe command("gcloud compute instance-groups list --project=#{project_id} --zones=#{test_zones} --format=json --filter='name:umig-static-ips'") do
    its(:exit_status) { should eq 0 }
    let(:groups) { JSON.parse(subject.stdout) }
    it "should find all 4 instance groups" do
      expect(groups.length).to eq 4
    end
  end
end
