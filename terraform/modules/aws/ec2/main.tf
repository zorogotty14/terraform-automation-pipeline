resource "aws_instance" "ec2_instances" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  tags = {
    Name   = "${var.company}-${var.team}-${var.region}-${var.instance_name}-${format("%02d", count.index + 1)}"
    name   = "${var.company}-${var.team}-${var.region}-${var.instance_name}-${format("%02d", count.index + 1)}"
    team   = var.team
    region = var.region
    type   = "ec2"
    count  = format("%02d", count.index + 1)
  }
}