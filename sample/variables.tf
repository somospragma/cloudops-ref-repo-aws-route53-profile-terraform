# =============================================================================
# Variables del Ejemplo
# PC-IAC-026: Definición de tipos para el ejemplo
# =============================================================================

variable "client" {
  description = "Nombre del cliente."
  type        = string
}

variable "project" {
  description = "Nombre del proyecto."
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue."
  type        = string
}

variable "region" {
  description = "Región de AWS."
  type        = string
  default     = "us-east-1"
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos."
  type        = map(string)
}

variable "profile_config" {
  description = "Configuración de Profiles."
  type = map(object({
    additional_tags = optional(map(string), {})
  }))
  default = {}
}

variable "resource_association_config" {
  description = "Asociaciones de recursos (endpoints) a Profiles."
  type = map(object({
    profile_key  = string
    resource_arn = string
  }))
  default = {}
}

variable "vpc_association_config" {
  description = "Asociaciones de VPCs a Profiles."
  type = map(object({
    profile_key = string
    vpc_id      = string
  }))
  default = {}
}
