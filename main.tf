/*
 * Create application load balancer
 */
resource "aws_alb" "alb" {
  name               = coalesce(var.alb_name, "alb-${var.app_name}-${var.app_env}")
  internal           = var.internal
  security_groups    = var.security_groups
  subnets            = var.subnets
  load_balancer_type = var.load_balancer_type
  idle_timeout       = var.idle_timeout
  ip_address_type    = var.enable_ipv6 ? (var.disable_public_ipv4 ? "dualstack-without-public-ipv4" : "dualstack") : "ipv4"

  tags = {
    Name     = coalesce(var.alb_name, "alb-${var.app_name}-${var.app_env}")
    app_name = var.app_name
    app_env  = var.app_env
  }
}

/*
 * Create target group for ALB
 */
resource "aws_alb_target_group" "default" {
  name     = coalesce(var.tg_name, "tg-${var.app_name}-${var.app_env}")
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.health_check_status_codes
  }
}

/*
 * Create listeners to connect ALB to target group
 */
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.default.arn
    type             = "forward"
  }
}

# logging

resource "aws_cloudwatch_log_group" "alb_access" {
  name              = "/aws/alb/${aws_alb.alb.name}/access"
  retention_in_days = var.access_log_retention_in_days
}

resource "aws_cloudwatch_log_delivery_source" "alb_access" {
  name         = "${aws_alb.alb.name}-access"
  log_type     = "ALB_ACCESS_LOGS"
  resource_arn = aws_alb.alb.arn
}

resource "aws_cloudwatch_log_delivery_destination" "alb_access" {
  name          = "${aws_alb.alb.name}-access-cwl"
  output_format = "json"

  delivery_destination_configuration {
    destination_resource_arn = aws_cloudwatch_log_group.alb_access.arn
  }
}

resource "aws_cloudwatch_log_delivery" "alb_access" {
  delivery_source_name     = aws_cloudwatch_log_delivery_source.alb_access.name
  delivery_destination_arn = aws_cloudwatch_log_delivery_destination.alb_access.arn
}
