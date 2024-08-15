
module "minimal" {
  source = "../"

  app_name        = ""
  app_env         = ""
  vpc_id          = ""
  security_groups = [""]
  subnets         = [""]
  certificate_arn = ""
}

module "full" {
  source = "../"

  app_name                  = ""
  app_env                   = ""
  vpc_id                    = ""
  security_groups           = [""]
  subnets                   = [""]
  certificate_arn           = ""
  port                      = ""
  protocol                  = ""
  alb_name                  = ""
  internal                  = true
  ssl_policy                = ""
  tg_name                   = ""
  health_check_interval     = ""
  health_check_path         = ""
  health_check_port         = ""
  health_check_protocol     = ""
  health_check_timeout      = ""
  healthy_threshold         = ""
  unhealthy_threshold       = ""
  health_check_status_codes = ""
  idle_timeout              = ""
  load_balancer_type        = ""
  enable_ipv6               = true
}

output "id" {
  value = module.full.id
}

output "arn" {
  value = module.full.arn
}

output "dns_name" {
  value = module.full.dns_name
}

output "default_tg_id" {
  value = module.full.default_tg_id
}

output "default_tg_arn" {
  value = module.full.default_tg_arn
}

output "https_listener_arn" {
  value = module.full.https_listener_arn
}


provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
