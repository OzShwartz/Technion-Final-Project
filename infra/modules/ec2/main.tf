resource "aws_instance" "main" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.ssh_key_name
  user_data              = var.user_data

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  tags = {
    Name = var.name
  }
}

output "instance_id" {
  value = aws_instance.main.id
}
