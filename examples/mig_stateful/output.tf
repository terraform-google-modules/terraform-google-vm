# output "instance_id" {
#   description = "The server-assigned unique identifier of this instance."
#   value       = "${element(module.instance.id, 0)}"
# }
# output "instance_internal_ip" {
#   description = "The internal ip address of the instance, either manually or dynamically assigned."
#   value       = "${element(module.instance.internal_ips, 0)}"
# }
output "instance_template_self_link" {
  description = "Self-link of instance template"
  value       = module.instance_template.self_link
}

output "mig_self_link" {
  description = "Self-link for managed instance group"
  value       = module.mig.self_link
}
