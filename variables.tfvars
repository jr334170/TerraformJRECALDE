aws_region  = "us-east-1"
aws_profile = "ort"

vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
az                 = "us-east-1a"
vpc_name           = "vpc-terraform-2"

ami_id        = "ami-0c02fb55956c7d316"
instance_type = "t2.micro"
key_name      = "vockey"
instance_name = "ec2-modulo-terraform-2"

# Si se omiten, toman el default ["0.0.0.0/0"]
# allowed_ssh_cidrs  = ["0.0.0.0/0"]
# allowed_http_cidrs = ["0.0.0.0/0"]
