#--- loadbalancing/variables.tf ---
variable "vpc_id" {
  type = string
 
}

variable "security_groups" {
  type = string
  
}
variable "public_subnet" {
  type = list(string)

}



variable "tg_protocol" {
  type = string
  
}

variable "tg_port" {
    type = string
  
}

variable "listener_protocol" {
    type = string
 
}

variable "listener_port" {
    type = string
  
}
// sg-variables 

variable "sg_name" {
  type = string
  description = "Tag Name for sg"
}

