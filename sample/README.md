# Ejemplo de Uso - Route 53 Profile Module

## Descripción

Este ejemplo demuestra cómo consumir el módulo `route53-profile-module` para:
1. Crear un Route 53 Profile
2. Asociar VPC Endpoints al Profile
3. Asociar una VPC spoke al Profile

## Ejecución

```bash
cd sample/
terraform init
terraform plan
terraform apply
```

## Flujo de Datos (PC-IAC-026)

```
terraform.tfvars → variables.tf → data.tf → locals.tf → main.tf → ../
```
