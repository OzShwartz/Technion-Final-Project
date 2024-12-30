resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.volume_type
  tags = {
    Name = var.name
  }
}

resource "aws_volume_attachment" "this" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.this.id
  instance_id = var.instance_id
  force_detach = var.force_detach
}
