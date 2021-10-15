//variable "public_key_location" {}
//variable "private_key_location" {}
variable "instance_type_webserver" {}
variable "az_project_in" {}
variable "bootstrap_script_file" {}
variable "project_environment" {}
variable "project_name" {}
variable "tags_common" {
  description = "Common tags for all resources"
  type        = map(any)
}
variable "vpc_security_group_ids" {}
variable "subnet_id" {}
variable "ami_name" {}


/*
variable "region_project_in"              { default = "us-east-1" }

variable "vpc_cidr_block"                 { default = "192.168.0.0/16" }
variable "subnet_cidr_block"              { default = "192.168.1.0/24" }
variable "ports_to_open"                  { default = [ "80", "443", "8080" ] }
variable "ip_for_ssh_inbound_connection"  { default = "0.0.0.0/0" }


variable "env_prefix"                     { default = "Dev" }
variable "project_environment"            { default = "Dev"}
variable "project_name"                   { default = "Project" }
variable "project_owner"                  { default = "GamKon" }

variable "tfstate_s3_bucket"              { default = "terraform-state-files-gamkon" }

variable "tags_common" {
  description = "Common tags for all resources"
  type = map
  default = {
    Owner   = "GamKon"
    Project = "Project"
    Environment = "Dev"
  }
}
*/