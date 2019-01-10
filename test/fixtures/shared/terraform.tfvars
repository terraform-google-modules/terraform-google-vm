project_id = "sso-test-project-c454"

credentials_path_relative = "../../../../credentials.json"

region = "us-central1"

service_account = {
  email  = "terraform@sso-test-project-c454.iam.gserviceaccount.com"
  scopes = ["cloud-platform"]
}

num_instances = 4

target_size = 4

instance_ips = [
  "10.128.0.10",
  "10.128.0.11",
  "10.128.0.12",
  "10.128.0.13",
]
