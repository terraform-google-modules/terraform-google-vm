# Copyright 2021 Google LLC
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
subnetwork_name = attribute('subnetwork_name')

expected_templates = 1
expected_disks = 1

control "Instance Template" do
  title "Alias IP Range Configuration"

  describe command("gcloud --project=#{project_id} compute instance-templates list --format=json --filter='name~^alias-ip-range*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        []
      end
    end

    describe "number of templates" do
      it "should be #{expected_templates}" do
        expect(data.length).to eq(expected_templates)
      end
    end

    describe "alias-ip-range/ipCidrRange is present" do
      it "'network interfaces' should have aliasIpRanges/ipCidrRange" do
        expect(data[0]['properties']['networkInterfaces'][0]['aliasIpRanges'][0]['ipCidrRange']).to eq("/24")
      end
    end

    describe "alias-ip-range/subnetworkRangeName is present" do
      it "'network interfaces' should have aliasIpRanges/subnetworkRangeName" do
        expect(data[0]['properties']['networkInterfaces'][0]['aliasIpRanges'][0]['subnetworkRangeName']).to eq(subnetwork_name)
      end
    end
  end
end
