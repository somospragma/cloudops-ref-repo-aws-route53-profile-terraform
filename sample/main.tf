# =============================================================================
# Invocación del Módulo Padre (Route 53 Profile)
# PC-IAC-026: Solo invocar módulo con local.* (nunca var.* directo)
# PC-IAC-013: Orden estricto de atributos
# =============================================================================

module "route53_profile" {
  # A. Fuente del Módulo (módulo padre)
  source = "../"

  # B. Providers
  providers = {
    aws.project = aws.principal
  }

  # C. Variables de Gobernanza
  client      = var.client
  project     = var.project
  environment = var.environment

  # E. Variables de Configuración (transformadas en locals.tf)
  profile_config              = local.profile_config_transformed
  resource_association_config = local.resource_association_config_transformed
  vpc_association_config      = local.vpc_association_config_transformed
}
