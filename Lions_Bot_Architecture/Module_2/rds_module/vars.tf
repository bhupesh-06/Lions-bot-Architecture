# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "vpc_id" {
  type = string
  
}
variable "identifier" {
  type = string

  description = "Identifier for your DB"
}

variable "storage" {
  type = string
  description = "Storage size in GB"
}

variable "engine" {
  type = string
  description = "Engine type, example values mysql, postgres"
}

variable "engine_version" {
  type = string
  description = "Engine version"
}

variable "instance_class" {
  type = string
  description = "Instance class"
}

variable "db_name" {
  type = string
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