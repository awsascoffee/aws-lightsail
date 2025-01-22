provider "aws" {}

resource "aws_lightsail_container_service" "main" {
  name  = var.name
  power = var.power
  scale = 1
}

resource "aws_lightsail_container_service_deployment_version" "main" {

  service_name = aws_lightsail_container_service.main.name

  container {
    container_name = "hello-world"
    image          = "amazon/amazon-lightsail:hello-world"
    ports = {
      80 = "HTTP"
    }
  }
  
  public_endpoint {
    container_name = "hello-world"
    container_port = 80
    health_check {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout_seconds     = 2
      interval_seconds    = 5
      path                = "/"
      success_codes       = "200-499"
    }
  }

  depends_on = [aws_lightsail_container_service.main]
}
