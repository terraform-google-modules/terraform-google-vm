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

expected_instances = 1
expected_total_disks = 3

control "Compute Instances" do
  title "VM Configuration"

  describe command("gcloud --project=#{project_id} compute instances list --format=json --filter='name~instance-disk-snapshot*'") do
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
        data.find { |i| i['name'] == "instance-disk-snapshot-001" }
      end

      it "should be in zone us-central1-a}" do
        expect(instance['zone']).to match(/.*us-central1-a$/)
      end
    end
  end
end

control "Compute Disks" do
  title "Snapshot Configuration"

  describe command("gcloud --project=#{project_id} compute disks list --format=json --filter='name~instance-disk-snapshot*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        []
      end
    end

    describe "number of disks" do
      it "should be #{expected_total_disks}" do
        expect(data.length).to eq(expected_total_disks)
      end
    end

    describe "boot disk" do
      let(:disk) do
        data.find { |d| d['name'] == 'instance-disk-snapshot-001' }
      end

      it "should not have any backup resource policy" do
        expect(disk).not_to include ("resourcePolicies")
      end
    end

    describe "additional disk 1" do
      let(:disk) do
        data.find { |d| d['name'] == 'instance-disk-snapshot-001-1' }
      end

      it "should have a backup resource policy" do
        expect(disk).to include ("resourcePolicies")
      end

      it "resource policy name should be backup-policy-test" do
        expect(disk['resourcePolicies'].join(', ')).to match(/.*backup-policy-test.*/)
      end
    end

    describe "additional disk 2" do
      let(:disk) do
        data.find { |d| d['name'] == 'instance-disk-snapshot-001-2' }
      end

      it "should have a backup resource policy" do
        expect(disk).to include ("resourcePolicies")
      end

      it "resource policy name should be backup-policy-test" do
        expect(disk['resourcePolicies'].join(', ')).to match(/.*backup-policy-test.*/)
      end
    end
  end
end
