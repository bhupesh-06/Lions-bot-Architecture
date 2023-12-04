


variable "region" {
  type = string
  description = "AWS Deployment region.."
  
}

variable "aws_lb_arn1" {
  type = string 
  description = "ARN of your LoadBalance that you want to attach with WAF.."
  
}