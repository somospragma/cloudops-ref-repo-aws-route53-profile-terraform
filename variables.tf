# =============================================================================
# Variables de Entrada del Módulo Route 53 Profile
# PC-IAC-002: Variables Obligatorias y Buenas Prácticas de Declaración
# =============================================================================

# -----------------------------------------------------------------------------
# Variables de Gobernanza (Obligatorias)
# PC-IAC-002: Variables de Control Globales
# -----------------------------------------------------------------------------

variable "client" {
  description = "Nombre del cliente o unidad de negocio."
  type        = string

  validation {
    condition     = length(var.client) > 0
    error_message = "La variable 'client' no puede estar vacía."
  }
}

variable "project" {
  description = "Nombre del proyecto."
  type        = string

  validation {
    condition     = length(var.project) > 0
    error_message = "La variable 'project' no puede estar vacía."
  }
}

variable "environment" {
  description = "Entorno de despliegue (dev, qa, pdn)."
  type        = string

  validation {
    condition     = contains(["dev", "qa", "pdn", "stg", "uat", "prod", "poc"], var.environment)
    error_message = "La variable 'environment' debe ser uno de: dev, qa, pdn, stg, uat, prod, poc."
  }
}

# -----------------------------------------------------------------------------
# Configuración de Route 53 Profiles
# PC-IAC-002: map(object) para estabilidad con for_each
# PC-IAC-025: El nombre viene construido desde el Root
# -----------------------------------------------------------------------------

variable "profile_config" {
  description = <<-EOT
    Mapa de Route 53 Profiles a crear.
    
    Atributos:
    - name: Nombre completo del Profile (construido en el Root, PC-IAC-025)
    - additional_tags: Tags adicionales específicos del recurso
  EOT

  type = map(object({
    name            = string
    additional_tags = optional(map(string), {})
  }))

  default = {}

  validation {
    condition = alltrue([
      for key, config in var.profile_config : length(config.name) > 0
    ])
    error_message = "Cada profile debe tener un 'name' no vacío."
  }
}

# -----------------------------------------------------------------------------
# Asociaciones de Recursos al Profile (VPC Endpoints)
# PC-IAC-002: map(object) para estabilidad con for_each
# -----------------------------------------------------------------------------

variable "resource_association_config" {
  description = <<-EOT
    Mapa de asociaciones de recursos (VPC Endpoints) a Profiles.
    Replica el paso de "agregar endpoints al profile" hecho por consola.
    
    Atributos:
    - name: Nombre de la asociación
    - profile_key: Clave del profile en profile_config
    - resource_arn: ARN del recurso a asociar (VPC Endpoint ARN)
    - resource_properties: Propiedades opcionales del recurso (JSON string)
  EOT

  type = map(object({
    name                = string
    profile_key         = string
    resource_arn        = string
    resource_properties = optional(string, null)
  }))

  default = {}

  validation {
    condition = alltrue([
      for key, config in var.resource_association_config : length(config.resource_arn) > 0
    ])
    error_message = "Cada resource_association debe tener un 'resource_arn' no vacío."
  }
}

# -----------------------------------------------------------------------------
# Asociaciones de VPCs al Profile
# PC-IAC-002: map(object) para estabilidad con for_each
# -----------------------------------------------------------------------------

variable "vpc_association_config" {
  description = <<-EOT
    Mapa de asociaciones de VPCs a Profiles.
    Replica el paso de "agregar VPC spoke al profile" hecho por consola.
    
    Atributos:
    - name: Nombre de la asociación
    - profile_key: Clave del profile en profile_config (usar si el profile se crea aquí)
    - profile_id: ID del profile externo compartido vía RAM (usar si el profile NO se crea aquí)
    - vpc_id: ID de la VPC a asociar
    - additional_tags: Tags adicionales
    
    Nota: Usar profile_key O profile_id, no ambos.
    - profile_key: cuando el profile se crea en este mismo módulo (cuenta Networking)
    - profile_id: cuando el profile viene compartido vía RAM (cuentas spoke)
  EOT

  type = map(object({
    name            = string
    profile_key     = optional(string, "")
    profile_id      = optional(string, "")
    vpc_id          = string
    additional_tags = optional(map(string), {})
  }))

  default = {}

  validation {
    condition = alltrue([
      for key, config in var.vpc_association_config : length(config.vpc_id) > 0
    ])
    error_message = "Cada vpc_association debe tener un 'vpc_id' no vacío."
  }
}
