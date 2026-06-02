# =============================================================================
# Recursos Principales - Route 53 Profiles
# PC-IAC-010: for_each obligatorio para colecciones
# PC-IAC-005: provider = aws.project en cada recurso
# PC-IAC-004: Tags con merge (Name + additional_tags)
# PC-IAC-023: Solo recursos intrínsecos al servicio (Profile)
# =============================================================================

# -----------------------------------------------------------------------------
# Route 53 Profile
# Crea el Profile que agrupa la configuración DNS compartida
# -----------------------------------------------------------------------------

resource "aws_route53profiles_profile" "this" {
  provider = aws.project
  for_each = var.profile_config

  name = each.value.name

  # PC-IAC-004: Tags específicos del recurso
  tags = merge(
    { Name = each.value.name },
    each.value.additional_tags
  )
}

# -----------------------------------------------------------------------------
# Resource Associations (VPC Endpoints → Profile)
# Asocia recursos (VPC Endpoints) al Profile
# Replica: "Agregar endpoints al profile" en consola
# -----------------------------------------------------------------------------

resource "aws_route53profiles_resource_association" "this" {
  provider = aws.project
  for_each = var.resource_association_config

  name         = each.value.name
  profile_id   = aws_route53profiles_profile.this[each.value.profile_key].id
  resource_arn = each.value.resource_arn

  resource_properties = each.value.resource_properties
}

# -----------------------------------------------------------------------------
# VPC Associations (VPCs → Profile)
# Asocia VPCs spoke al Profile para que hereden la configuración DNS
# Replica: "Agregar VPC al profile" en consola
# Soporta dos modos:
#   - profile_key: cuando el profile se crea aquí (cuenta Networking)
#   - profile_id: cuando el profile viene compartido vía RAM (cuentas spoke)
# -----------------------------------------------------------------------------

resource "aws_route53profiles_association" "this" {
  provider = aws.project
  for_each = var.vpc_association_config

  name        = each.value.name
  profile_id  = length(each.value.profile_id) > 0 ? each.value.profile_id : aws_route53profiles_profile.this[each.value.profile_key].id
  resource_id = each.value.vpc_id

  # PC-IAC-004: Tags específicos del recurso
  tags = merge(
    { Name = each.value.name },
    each.value.additional_tags
  )
}
