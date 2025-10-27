variable "region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "thunder_vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR range"
  default     = "10.0.0.0/16"
}

variable "Public_Subnet_names" {
  type        = map(list(string))
  description = "Public Subnet Names"
  default = {
    "us-east-1a" = ["Thunder Public Subnet us-east-1a"]
    "us-east-1b" = ["Thunder Public Subnet us-east-1b"]
  }
}

variable "Public_Subnet_CIDR" {
  type        = map(list(string))
  description = "Public Subner CIDR range"
  default = {
    "us-east-1a" = ["10.0.1.0/24"]
    "us-east-1b" = ["10.0.2.0/24"]
  }
}

variable "Private_Subnet_Names" {
  type        = map(list(string))
  description = "Private Subnet Names"
  default = {
    "us-east-1a" = ["Thunder Private Subnet us-east-1a"]
    "us-east-1b" = ["Thunder Provate Subnet us-east-1b"]
  }
}

variable "Private_Subnet_CIDR" {
  type        = map(list(string))
  description = "Private Subnet CIDR"
  default = {
    "us-east-1a" = ["10.0.3.0/24"]
    "us-east-1b" = ["10.0.4.0/24"]
  }
}

variable "Public_Route_Table_Name" {
  type        = string
  description = "Public Route Table Name"
  default     = "Thunder Public RT"
}

variable "Private_Route_Table_Name" {
  type        = string
  description = "Private Route Table Name"
  default     = "Thunder Private RT"
}

variable "Inetnet_Gateway_Name" {
  type        = string
  description = "Internet Gateway Name"
  default     = "Thunder IGW"
}

variable "instance_ami" {
  type        = string
  description = "AMI ID for EC2 instance"
  default     = "ami-0360c520857e3138f" # ubuntu-noble-24.04-amd64 
}

variable "instance_type" {
  type        = string
  description = "Instance type for EC2 instances"
  default     = "t2.micro"
}
