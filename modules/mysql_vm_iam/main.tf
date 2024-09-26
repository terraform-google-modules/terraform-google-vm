resource "google_compute_instance_iam_member" "computeAdmin" {
  count         = length(var.instance_hostnames)
  project       = var.project_id
  zone          = var.instance_zones[count.index]
  instance_name = var.instance_hostnames[count.index]
  role          = "roles/compute.instanceAdmin.v1"
  member        = var.service_account
}

resource "google_compute_instance_iam_member" "osadmin" {
  count         = length(var.instance_hostnames)
  project       = var.project_id
  zone          = var.instance_zones[count.index]
  instance_name = var.instance_hostnames[count.index]
  role          = "roles/compute.osAdminLogin"
  member        = var.iam_dba_email
}

resource "google_secret_manager_secret_iam_member" "secrets" {
  count     = length(var.secrets)
  project   = var.project_id
  secret_id = var.secrets[count.index]
  role      = "roles/secretmanager.secretAccessor"
  member    = var.service_account
}

resource "google_iap_tunnel_iam_member" "iap_tunnel" {
  count   = var.iap_accessor_iam == null ? 0 : length(var.instance_hostnames)
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = var.iap_accessor_iam

  condition {
    title       = "iap_access_to_${var.instance_hostnames[count.index]}"
    description = "IAP access to MySQL"
    expression  = "destination.ip == '${var.instance_ips[count.index]}' && destination.port == 3306"
  }
}

resource "google_compute_instance_iam_member" "instance_access" {
  count         = var.iap_accessor_iam == null ? 0 : length(var.instance_hostnames)
  project       = var.project_id
  zone          = var.instance_zones[count.index]
  instance_name = var.instance_hostnames[count.index]
  role          = "roles/compute.instanceAdmin.v1"
  member        = var.iap_accessor_iam
}
