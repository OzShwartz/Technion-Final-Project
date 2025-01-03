# Technion-Final-Project

<img width="805" alt="ProjectArc" src="https://github.com/user-attachments/assets/433217c5-aaf9-4baa-8262-2aebba78a2f0" />


Setup

Environment Variables

Set the following:

EC2_IP: Public IP of the EC2 instance.

EC2_HOST: Hostname or DNS.

TERRAFORM_MANUAL_APPROVALS: Enable/disable manual approvals.

Secrets:

GIT_PAT: Git Personal Access Token.

DOCKER_USERNAME: Docker Hub username.

DOCKER_PASSWORD: Docker Hub password.

DOCKER_EMAIL: Docker Hub email.

Requirements:

Runners:

Create Git Runners: host-self linux

Connect and configure in EC2 Git Runner:

   sudo yum update -y
    sudo yum install -y libicu
    mkdir actions-runner && cd actions-runner
    curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
    tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz
    ./config.sh --url https://github.com/OzShwartz/Technion-Final-Project --token XXXXXXXXXXXXXXXXXXXXXXXXXXXXX --unattended --replace
    sudo ./svc.sh install
    sudo ./svc.sh start 

Install Flask and its modules:

pip install flask

Terraform Configuration

Create an S3 bucket matching the name in backend.tf:

terraform {
  backend "s3" {
    bucket = "your-bucket-name"
    key    = "terraform/state"
    region = "your-region"
  }
}

Deployment

Clone the repo:

git clone https://github.com/your-repo/Technion-Final-Project.git

cd Technion-Final-Project

Set environment variables and secrets.

Initialize and apply Terraform:

terraform init
terraform apply

Build and deploy Docker image:

docker build -t oz23/pyui .
docker push oz23/pyui


ssh -i <your-key.pem> ec2-user@<EC2_IP>
docker pull oz23/pyui
docker run -d -p 5000:5001 oz23/pyui
