# =============================================================================
# Outputs del Módulo Route 53 Profile
# PC-IAC-007: Outputs granulares (IDs, ARNs)
# PC-IAC-014: Splat Expressions para extracción
# =============================================================================

# -----------------------------------------------------------------------------
# Profile Outputs
# -----------------------------------------------------------------------------

output "profile_ids" {
  description = "Mapa de IDs de los Route 53 Profiles creados."
  value       = { for key, profile in aws_route53profiles_profile.this : key => profile.id }
}

output "profile_arns" {
  description = "Mapa de ARNs de los Route 53 Profiles creados."
  value       = { for key, profile in aws_route53profiles_profile.this : key => profile.arn }
}

output "profile_statuses" {
  description = "Mapa de estados de los Route 53 Profiles creados."
  value       = { for key, profile in aws_route53profiles_profile.this : key => profile.status }
}

# -----------------------------------------------------------------------------
# Resource Association Outputs
# -----------------------------------------------------------------------------

output "resource_association_ids" {
  description = "Mapa de IDs de las asociaciones de recursos (endpoints) a Profiles."
  value       = { for key, assoc in aws_route53profiles_resource_association.this : key => assoc.id }
}

# -----------------------------------------------------------------------------
# VPC Association Outputs
# -----------------------------------------------------------------------------

output "vpc_association_ids" {
  description = "Mapa de IDs de las asociaciones de VPCs a Profiles."
  value       = { for key, assoc in aws_route53profiles_association.this : key => assoc.id }
}
