# =============================================================================
# Data Sources del Ejemplo
# PC-IAC-026: Obtener IDs dinámicos para inyectar en locals.tf
# =============================================================================

# Obtener VPC Endpoints por tag Name
data "aws_vpc_endpoint" "ssm" {
  provider = aws.principal

  filter {
    name   = "tag:Name"
    values = ["${var.client}-${var.project}-${var.environment}-vpce-ssm"]
  }
}

data "aws_vpc_endpoint" "ssmmessages" {
  provider = aws.principal

  filter {
    name   = "tag:Name"
    values = ["${var.client}-${var.project}-${var.environment}-vpce-ssmmessages"]
  }
}

data "aws_vpc_endpoint" "ec2messages" {
  provider = aws.principal

  filter {
    name   = "tag:Name"
    values = ["${var.client}-${var.project}-${var.environment}-vpce-ec2messages"]
  }
}

# Obtener VPC spoke por tag Name
data "aws_vpc" "kappa" {
  provider = aws.principal

  filter {
    name   = "tag:Name"
    values = ["pragma-kappa-dev-vpc"]
  }
}
