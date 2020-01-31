# Upgrading to MIG v2.0 (from v1.X)

The v2.0 release of MIG is a backwards incompatible release. The health check related variables `http_healthcheck_enable`, `tcp_healthcheck_enable`, `hc_initial_delay_sec`, `hc_interval_sec`, `hc_timeout_sec`, `hc_healthy_threshold`, `hc_unhealthy_threshold`, `hc_path` and `hc_port` were replaced with the new object type parameter called `health_check`.

## Migration Instructions

### Health Check Arguments Changes

Version 1.X of MIG used the optional health check variables:

```hcl

module "vm_mig" {
  source                  = "terraform-google-modules/vm/google//modules/mig"
  version                 = "1.3.0"
  ...
  /* health checks */
  http_healthcheck_enable = true
  tcp_healthcheck_enable  = false
  hc_initial_delay_sec    = 30
  hc_interval_sec         = 30
  hc_timeout_sec          = 10
  hc_healthy_threshold    = 1
  hc_unhealthy_threshold  = 5
  hc_path                 = "/"
  hc_port                 = 80
}
```

Version 2.X of MIG uses the new object parameter named `health_check`:

```hcl
module "mig" {
  source                  = "terraform-google-modules/vm/google//modules/mig"
  version                 = "1.3.0"
  ...
  health_check = {
    type                = "http"
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    host                = ""
  }
}
```

