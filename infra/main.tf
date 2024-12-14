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
