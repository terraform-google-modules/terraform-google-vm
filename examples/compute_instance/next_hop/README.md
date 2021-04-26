# Instance as next hop for a route

This example creates a VM instance with IP forwarding enabled so that the
VM can forward a packet originated by another VM.

To use a VM as a next hop for a route, the VM needs to receive packets that have
destinations other than itself. Because it forwards those packets, the packet
sources are different from its own internal IP address. To accomplish this, you
must enable IP forwarding for the VM. When IP forwarding is enabled, Google
Cloud does not enforce packet source and destination checking.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
