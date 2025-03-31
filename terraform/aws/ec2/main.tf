provider "aws" {
  region = var.region
}

module "ec2_instances" {
  source         = "../../modules/aws/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  instance_count = var.instance_count
  subnet_id      = var.subnet_id
  key_name       = var.key_name

  company        = var.company
  team           = var.team
  region         = var.region
  instance_name  = var.instance_name
}
