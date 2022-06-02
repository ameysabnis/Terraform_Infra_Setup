variable "aws_region" {
       description = "The AWS region to create things in." 
       default     = "us-east-1" 
}

variable "access_key" {
	description =" Access key for AWS EC2 instance"
	default = "AKIA5S7HKNOFBZUJLC3Y"
}

variable "secret_key" {
	description = "Secret key for AWS EC2 instance"
	default = "OBhk4/PttKwTxTPoVSowH041YtykrK3pmqcbpWM5"
}

variable "key_name" { 
    description = " SSH keys to connect to ec2 instance" 
    default     =  "Devops_Terraform_Key" 
}

variable "instance_type" { 
    description = "instance type for ec2" 
    default     =  "t2.micro" 
}

variable "security_group" { 
    description = "Name of security group" 
    default     = "my-jenkins-security-group" 
}

variable "tag_name" { 
    description = "Tag Name of for Ec2 instance" 
    default     = "terraform-ec2-instance" 
} 
variable "ami_id" { 
    description = "AMI for Ubuntu Ec2 instance" 
    default     = "ami-0c4f7023847b90238"
}

