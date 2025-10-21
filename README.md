# Terraform Module for Application Load Balancer

This module is used to create an application load balancer along with security
groups for traffic and a default target group. It was previously published
at https://github.com/sil-org/terraform-modules/aws/alb.

## What this includes

- ALB named after `app_name` and `app_env`
- ALB target group
- HTTPS listener for ALB / Target Group

This module is published in [Terraform Registry](https://registry.terraform.io/modules/sil-org/alb/aws/latest).

## Usage Example

```hcl
module "asg" {
  source = "sil-org/alb"
  version = "0.1.0"
  
  app_name        = var.app_name
  app_env         = var.app_env
  vpc_id          = module.vpc.id
  security_groups = [module.vpc.vpc_default_sg_id,module.cloudflare-sg.id]
  subnets         = [module.vpc.public_subnet_ids]
  certificate_arn = data.aws_acm_certificate.name.arn
}
```
