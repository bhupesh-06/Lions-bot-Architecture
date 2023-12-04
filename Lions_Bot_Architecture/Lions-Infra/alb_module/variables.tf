#--- loadbalancing/variables.tf ---
variable "vpc1_id" {
  type = string
 
}


variable "public_subnets1" {
  

}

 
variable "tg_protocol1" {
  type = string
  
}

variable "tg_port1" {
    type = string
  
}

variable "listener_port1" {
    type = string
 
}


variable "listener_protocol1" {
  type = string
  
}
variable "target_id" {
  
}
// sg-variables 

variable "sg_name1" {
  type = string
  description = "Tag Name for sg"
}

