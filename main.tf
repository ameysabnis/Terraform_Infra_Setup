provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

#Create security group with firewall rules
resource "aws_security_group" "security_jenkins_grp" {
  name        = var.security_group
  description = "security group for jenkins"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }

provisioner "remote-exec" {
 inline = [
  "sudo apt update && upgrade",
  "sudo apt install -y python3.8",
  "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
  "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
  "sudo apt-get update",
  "sudo apt-get install fontconfig openjdk-11-jre",
  "sudo apt-get install -y net-tools",
  "wget https://pkg.jenkins.io/debian-stable/binary/jenkins_2.332.3_all.deb",
  "sudo dpkg -i jenkins_2.332.3_all.deb",
  "sudo systemctl start jenkins",
  "sudo systemctl enable jenkins"
  ]
}

}

resource "aws_instance" "terraform-ec2-instance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "myElasticIP" {
  vpc      = true
  instance = aws_instance.terraform-ec2-instance.id
tags= {
    Name = "jenkins_elastic_ip"
  }
}
