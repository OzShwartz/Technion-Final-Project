module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source      = "./modules/sg"
  for_each    = var.sg_map

  name        = each.key
  vpc_id      = module.vpc.vpc_id
  extra_ports = try(each.value.extra_ports, [])
}

module "ec2" {
  source            = "./modules/ec2"
  for_each          = var.ec2_map

  name               = each.key
  ami                = try(each.value.ami, var.ami)
  instance_type      = try(each.value.instance_type, var.instance_type)
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.sg[each.key].sg_id]
  ssh_key_name       = try(each.value.ssh_key_name, var.ssh_key_name)
  user_data          = try(each.value.user_data, "")

  depends_on = [ module.sg ]
}


module "ebs" {
  source = "./modules/ebs"
  for_each = var.ec2_map

  name            = "${each.key}-ebs-volume"
  availability_zone = var.availability_zone
  volume_size     = try(each.value.ebs.volume_size, var.default_ebs_size)
  volume_type     = try(each.value.ebs.volume_type, var.default_ebs_type)
  device_name     = try(each.value.ebs.device_name, "/dev/xvdf")
  instance_id     = module.ec2[each.key].instance_id
  force_detach    = try(each.value.ebs.force_detach, false)
  depends_on      = [module.ec2]
}

