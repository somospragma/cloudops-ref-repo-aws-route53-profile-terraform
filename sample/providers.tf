# =============================================================================
# Configuración de Provider para el Ejemplo
# PC-IAC-005: Provider con alias principal y default_tags
# =============================================================================

provider "aws" {
  region  = var.region
  alias   = "principal"
  profile = "pra_chaptercloudops_lab"

  default_tags {
    tags = var.common_tags
  }
}
