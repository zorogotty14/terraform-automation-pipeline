variable "ami" {
  description = "AMI ID to use for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 1
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 login"
  type        = string
}

variable "tags" {
  description = "Common tags to assign to instances"
  type        = map(string)
  default     = {}
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
  description = "Region for naming convention"
  type        = string
}

variable "instance_name" {
  description = "Logical name for the EC2 instance"
  type        = string
}
