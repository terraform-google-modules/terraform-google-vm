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

expected_instances = 2
expected_instance_groups = 1

control "MIG" do
  title "Autoscaling & Health-Check Configuration"

  describe command("gcloud --project=#{project_id} compute instances list --format=json --filter='name~^mig-as*'") do
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
  end

  describe command("gcloud --project=#{project_id} compute instance-groups list --format=json --filter='name~^mig-as*'") do
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

  describe command("gcloud --project=#{project_id} compute instance-groups managed list --format=json --filter='name~^mig-as*'") do
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
        expect(data[0]['autoscaler']['autoscalingPolicy']['minNumReplicas']).to eq(2)
      end
    end

    describe "autoscaler scaling policy" do
      it "cpuUtilization target should be 0.4" do
        expect(data[0]['autoscaler']['autoscalingPolicy']['cpuUtilization']['utilizationTarget']).to eq(0.4)
      end
    end
  end

  describe command("gcloud --project=#{project_id} compute health-checks list --format=json --filter='name~^mig-https-hc*'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        []
      end
    end

    describe "https health check settings" do
      it "host should be localhost" do
        expect(data[0]['httpsHealthCheck']['host']).to eq('localhost')
      end
    end

    describe "https health check settings" do
      it "port should be 443" do
        expect(data[0]['httpsHealthCheck']['port']).to eq(443)
      end
    end

    describe "https health check settings" do
      it "requestPath should be /" do
        expect(data[0]['httpsHealthCheck']['requestPath']).to eq('/')
      end
    end

    describe "https health check settings" do
      it "healthyThreshold should be 2" do
        expect(data[0]['healthyThreshold']).to eq(2)
      end
    end

    describe "https health check settings" do
      it "checkIntervalSec should be 5" do
        expect(data[0]['healthyThreshold']).to eq(5)
      end
    end

    describe "https health check settings" do
      it "unhealthyThreshold should be 2" do
        expect(data[0]['healthyThreshold']).to eq(2)
      end
    end
  end

end
