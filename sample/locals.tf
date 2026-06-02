# =============================================================================
# Transformaciones del Ejemplo
# PC-IAC-026: Inyección dinámica de IDs desde data sources
# PC-IAC-025: Construcción de nomenclatura en el Root
# =============================================================================

locals {
  governance_prefix = "${var.client}-${var.project}-${var.environment}"

  # ---------------------------------------------------------------------------
  # Transformar Profile Config - Inyectar nombre construido (PC-IAC-025)
  # ---------------------------------------------------------------------------
  profile_config_transformed = {
    for key, config in var.profile_config : key => {
      name            = "${local.governance_prefix}-profile-${key}"
      additional_tags = config.additional_tags
    }
  }

  # ---------------------------------------------------------------------------
  # Transformar Resource Associations - Inyectar ARNs desde data sources
  # PC-IAC-009: Inyección dinámica de valores
  # ---------------------------------------------------------------------------
  endpoint_arns = {
    "ssm"         = data.aws_vpc_endpoint.ssm.arn
    "ssmmessages" = data.aws_vpc_endpoint.ssmmessages.arn
    "ec2messages" = data.aws_vpc_endpoint.ec2messages.arn
  }

  resource_association_config_transformed = {
    for key, config in var.resource_association_config : key => {
      name                = "${local.governance_prefix}-profile-assoc-${key}"
      profile_key         = config.profile_key
      resource_arn        = length(config.resource_arn) > 0 ? config.resource_arn : local.endpoint_arns[key]
      resource_properties = null
    }
  }

  # ---------------------------------------------------------------------------
  # Transformar VPC Associations - Inyectar VPC IDs desde data sources
  # ---------------------------------------------------------------------------
  vpc_association_config_transformed = {
    for key, config in var.vpc_association_config : key => {
      name            = "${local.governance_prefix}-profile-vpc-${key}"
      profile_key     = config.profile_key
      vpc_id          = length(config.vpc_id) > 0 ? config.vpc_id : data.aws_vpc.kappa.id
      additional_tags = {}
    }
  }
}
