# =============================================================================
# Valores Locales y Transformaciones
# PC-IAC-003: Nomenclatura Estándar
# PC-IAC-012: Estructuras de Datos y Reutilización en Locals
# =============================================================================

locals {
  # ---------------------------------------------------------------------------
  # Prefijo de Gobernanza
  # PC-IAC-003: Construcción centralizada del prefijo base
  # ---------------------------------------------------------------------------
  governance_prefix = "${var.client}-${var.project}-${var.environment}"
}
