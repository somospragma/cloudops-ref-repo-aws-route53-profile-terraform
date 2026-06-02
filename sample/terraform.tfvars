# =============================================================================
# Valores de ejemplo para Route 53 Profile Module
# PC-IAC-026: Configuración declarativa sin IDs hardcodeados
# =============================================================================

client      = "pragma"
project     = "hubspoke"
environment = "dev"
region      = "us-east-1"

common_tags = {
  Client      = "pragma"
  Project     = "hubspoke"
  Environment = "dev"
  owner       = "cloudops-team"
  CostCenter  = "CC-NETWORKING-001"
}

# -----------------------------------------------------------------------------
# Profile Configuration
# Los nombres se construyen en locals.tf (PC-IAC-025)
# -----------------------------------------------------------------------------

profile_config = {
  "hub-endpoints" = {
    additional_tags = {
      Purpose = "centralized-endpoint-dns"
    }
  }
}

# -----------------------------------------------------------------------------
# Resource Associations (VPC Endpoints → Profile)
# resource_arn se obtiene desde data sources en locals.tf
# -----------------------------------------------------------------------------

resource_association_config = {
  "ssm" = {
    profile_key  = "hub-endpoints"
    resource_arn = "" # Se inyecta desde data source
  }
  "ssmmessages" = {
    profile_key  = "hub-endpoints"
    resource_arn = "" # Se inyecta desde data source
  }
  "ec2messages" = {
    profile_key  = "hub-endpoints"
    resource_arn = "" # Se inyecta desde data source
  }
}

# -----------------------------------------------------------------------------
# VPC Associations (VPCs → Profile)
# vpc_id se obtiene desde data sources en locals.tf
# -----------------------------------------------------------------------------

vpc_association_config = {
  "kappa" = {
    profile_key = "hub-endpoints"
    vpc_id      = "" # Se inyecta desde data source
  }
}
