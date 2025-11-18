variable "aws_region" {
  type = string
  default = "us-east-1"
}
#variable "nombres_servicios" {
#  description = "Nombres de mis instancias EC2 generadas por foreach"
#  type = set(string)
#}
variable "ruta_private_key" {
  description = "Ruta del archivo PEM para conexión SSH"
  type = string
}

# Para blue/green
variable "color_activo" {
  type = string
  default = "blue"
  description = "Para asignar un color en blue/green; por defecto blue"
}
