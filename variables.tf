/*
 * Required variables
 */
variable "app_name" {
  type = string
}

variable "app_env" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "subnets" {
  type = list(string)
}

variable "certificate_arn" {
  type = string
}

/*
 * Optional variables
 */
variable "port" {
  type    = string
  default = 80
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "alb_name" {
  description = "Manual override for ALB name (which is otherwise assembled from other given data)"
  type        = string
  default     = ""
}

variable "internal" {
  type    = bool
  default = false
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "tg_name" {
  description = "Manual override for ALB Target Group name (which is otherwise assembled from other given data)"
  type        = string
  default     = ""
}

variable "health_check_interval" {
  description = "Approximate amount of time, in seconds, between health checks of an individual target."
  type        = number
  default     = 30
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_port" {
  type    = string
  default = "traffic-port"
}

variable "health_check_protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check_timeout" {
  description = "Amount of time, in seconds, during which no response from a target means a failed health check."
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of consecutive health check successes required before considering a target healthy."
  type        = number
  default     = 5
}

variable "unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering a target unhealthy."
  type        = number
  default     = 2
}

variable "health_check_status_codes" {
  type    = string
  default = "200"
}

variable "idle_timeout" {
  description = "Time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "load_balancer_type" {
  type    = string
  default = "application"
}

variable "enable_ipv6" {
  description = "Set to `true` to enable IPv6"
  type        = bool
  default     = false
}

variable "disable_public_ipv4" {
  description = <<-EOT
    false: use public IPv4; true: if enable_ipv6 is true, ip_address_type will be "dualstack-without-public-ipv4",
    otherwise, "dualstack"
  EOT
  type        = bool
  default     = false
}
