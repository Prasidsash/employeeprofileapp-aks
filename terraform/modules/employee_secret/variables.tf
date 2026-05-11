variable "namespace_name" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "secret_data" {

  type = map(string)

  sensitive = true
}