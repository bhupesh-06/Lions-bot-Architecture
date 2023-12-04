# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "vpc1_id" {
  type = string
  
}
variable "identifier1" {
  type = string

  description = "Identifier for your DB"
}

variable "storage1" {
  type = string
  description = "Storage size in GB"
}

variable "engine1" {
  type = string
  description = "Engine type, example values mysql, postgres"
}

variable "engine_version1" {
  type = string
  description = "Engine version"
}

variable "instance_class1" {
  type = string
  description = "Instance class"
}

variable "db_name1" {
  type = string
  description = "db name"
}

variable "username1" {
  type = string
  description = "User name"
}

variable "password1" {
  type = string
  description = "password, provide through your ENV variables"
}