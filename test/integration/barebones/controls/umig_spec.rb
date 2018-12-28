# frozen_string_literal: true

require 'rubygems'
require 'json'
# this is the prescribed way to create variables in test from terraform test outputs
foo_id = attribute('foo_id', description="registering test fixture output 'foo_id'")
project_name = attribute('project_name', description="")
region = attribute('region', description="")

auth = `gcloud config set project #{project_name}`
set_project = `gcloud auth activate-service-account --key-file /root/static_build/tk-tester.json`

# this main control block is referenced in the .kitchen.yml file. All tests fall within it.
control "umig" do
  describe 'Static outputs' do
    it 'have become local variables' do
      expect(foo_id).to match /bar/
    end
  end
  
  # A dead simple test to determine the number of RUNNING hosts that match our naming scheme

  instances_list = JSON.parse(`gcloud compute instances list --filter="name:( guw1-dev-test-app-umig-server-type-0001-a-* )  status:( RUNNING )" --format json`)
  # puts instance_list
  instances_list_length = instances_list.length
  describe instances_list_length do
    expected_length = 3
    it "instances found RUNNING. Expected to find #{expected_length}." do
      expect(instances_list_length).to eq(expected_length)
    end
  end
end
