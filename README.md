# Route 53 Profile Module

Módulo de referencia para gestionar Route 53 Profiles, asociar VPC Endpoints y VPCs spoke.

## Descripción

Este módulo crea:
1. **Route 53 Profile** — Agrupa configuración DNS compartida
2. **Resource Associations** — Asocia VPC Endpoints (Interface) al Profile
3. **VPC Associations** — Asocia VPCs spoke al Profile para heredar DNS

## Uso

```hcl
module "route53_profile" {
  source = "git::https://github.com/somospragma/cloudops-ref-repo-aws-route53-profile-terraform.git?ref=v1.0.0"

  providers = {
    aws.project = aws.principal
  }

  client      = var.client
  project     = var.project
  environment = var.environment

  profile_config              = local.profile_config_transformed
  resource_association_config = local.resource_association_config_transformed
  vpc_association_config      = local.vpc_association_config_transformed
}
```

## Inputs

| Nombre | Descripción | Tipo | Requerido |
|--------|-------------|------|-----------|
| `client` | Nombre del cliente | `string` | Sí |
| `project` | Nombre del proyecto | `string` | Sí |
| `environment` | Entorno (dev, qa, pdn) | `string` | Sí |
| `profile_config` | Configuración de Profiles | `map(object)` | No |
| `resource_association_config` | Asociaciones de recursos (endpoints) | `map(object)` | No |
| `vpc_association_config` | Asociaciones de VPCs | `map(object)` | No |

## Outputs

| Nombre | Descripción |
|--------|-------------|
| `profile_ids` | Mapa de IDs de Profiles |
| `profile_arns` | Mapa de ARNs de Profiles |
| `profile_statuses` | Mapa de estados de Profiles |
| `resource_association_ids` | Mapa de IDs de asociaciones de recursos |
| `vpc_association_ids` | Mapa de IDs de asociaciones de VPCs |

## Requisitos

| Nombre | Versión |
|--------|---------|
| terraform | >= 1.0.0 |
| aws | >= 5.0.0 |

## Cumplimiento PC-IAC

| Regla | Implementación |
|-------|---------------|
| PC-IAC-001 | 10 archivos raíz + 8 sample/ |
| PC-IAC-002 | Variables con type, description, validation. map(object) |
| PC-IAC-004 | Tags con merge(Name + additional_tags) |
| PC-IAC-005 | Provider aws.project inyectado |
| PC-IAC-007 | Outputs granulares (IDs, ARNs) |
| PC-IAC-010 | for_each en todos los recursos |
| PC-IAC-011 | Sin data sources (prohibido en módulos) |
| PC-IAC-023 | Solo recursos de Route 53 Profiles |
| PC-IAC-025 | Nombre viene construido desde el Root |

## Decisiones de Diseño

1. **Sin PHZ**: Este módulo NO crea Private Hosted Zones. Solo gestiona Profiles y asociaciones.
2. **Endpoints como ARN**: Los VPC Endpoints se pasan como ARN (resource_arn), no se crean aquí.
3. **VPCs como ID**: Las VPCs se pasan como ID (vpc_id), no se buscan aquí.
4. **RAM Share separado**: El compartir vía RAM se hace con el ram-share-module existente.
