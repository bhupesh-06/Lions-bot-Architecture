variable "identifier" {
  
  description = "Identifier for your DB"
}
variable "storage" {
  
  description = "Storage size in GB"
}
variable "engine" {
  description = "Engine type, example values mysql, postgres"
}
variable "engine_version" {
  description = "Engine version"
}

variable "instance_class" {
 
  description = "Instance class"
}
variable "db_name" {
 
  description = "db name"
}
variable "username" {
  type = string
  description = "User name"
}
variable "password" {
  type = string
  description = "password, provide through your ENV variables"
}
variable "vpc_id" {
  type = string

  
}
