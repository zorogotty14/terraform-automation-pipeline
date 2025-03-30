variable "ami" {
  type        = string
  description = "AMI ID to use for the instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = 1
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where EC2 will be launched"
}

variable "key_name" {
  type        = string
  description = "Key pair name to access EC2 instances"
}



variable "company" {
  description = "Company name for naming convention"
  type        = string
}

variable "team" {
  description = "Team name for naming convention"
  type        = string
}

variable "region" {
  description = "Region name for naming convention"
  type        = string
}

variable "instance_name" {
  description = "Logical name for the EC2 instance"
  type        = string
}
