# =============================================================================
# Outputs del Ejemplo
# =============================================================================

output "profile_ids" {
  description = "IDs de los Profiles creados."
  value       = module.route53_profile.profile_ids
}

output "profile_arns" {
  description = "ARNs de los Profiles creados."
  value       = module.route53_profile.profile_arns
}

output "resource_association_ids" {
  description = "IDs de las asociaciones de recursos."
  value       = module.route53_profile.resource_association_ids
}

output "vpc_association_ids" {
  description = "IDs de las asociaciones de VPCs."
  value       = module.route53_profile.vpc_association_ids
}
