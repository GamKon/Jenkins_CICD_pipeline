variable "region_project_in" { default = "us-east-1" }
variable "az_project_in" { default = "us-east-1a" }
variable "vpc_cidr_block" { default = "192.168.0.0/16" }
variable "subnet_cidr_block" { default = "192.168.1.0/24" }
variable "ports_to_open" { default = ["80", "443", "8080"] }
variable "ip_for_ssh_inbound_connection" { default = "0.0.0.0/0" }
//variable "public_key_location" {}
//variable "private_key_location" {}
variable "instance_type_webserver" { default = "t2.micro" }
variable "ami_name" { default = "amzn2-ami-hvm-2.0.*-x86_64-gp2" }
variable "env_prefix" { default = "Dev" }
variable "project_environment" { default = "Dev" }
variable "project_name" { default = "Project" }
variable "project_owner" { default = "GamKon" }
variable "bootstrap_script_file" { default = "user_data.sh" }
variable "tfstate_s3_bucket" { default = "terraform-state-files-gamkon" }

variable "tags_common" {
  description = "Common tags for all resources"
  type        = map(any)
  default = {
    Owner       = "GamKon"
    Project     = "Project"
#    Environment = "Env"
  }
}
