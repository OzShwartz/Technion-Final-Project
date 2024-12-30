variable "ami" {
  default = "ami-0453ec754f44f9a4a"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "ssh_key_name" {
  type    = string
  default = "vockey"
}

variable "sg_map" {
  default = {
    "GitHub_Runner" = {
      extra_ports = [443]
    },
    "K8S_Cluster" = {}
  }
}

variable "ec2_map" {
  default = {
    "GitHub_Runner" = {
      ebs = {
        volume_size = 50
        volume_type = "gp2"
        device_name = "/dev/sdf"
        force_detach = true
      }
    },
    "K8S_Cluster" = {
      ebs = {
        volume_size = 100
        volume_type = "gp3"
      }
    }
  }
}

variable "default_ebs_size" {
  type    = number
  default = 30
}

variable "default_ebs_type" {
  type    = string
  default = "gp3"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

#   user_data = <<-EOF
#     #!/bin/bash
#     sudo yum update -y
#     sudo yum install -y libicu
#     mkdir actions-runner && cd actions-runner
#     curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
#     tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz
#     ./config.sh --url https://github.com/OzShwartz/Technion-Final-Project --token A2O2NWGHBS4ECNBQJIJMCS3HOKQ26 --unattended --replace
#     sudo ./svc.sh install
#     sudo ./svc.sh start
#   EOF
