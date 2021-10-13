variable "ports_to_open" {}
variable "ip_for_ssh_inbound_connection" {}
variable "project_environment" {}
variable "project_name" {}
variable "tags_common" {
  description = "Common tags for all resources"
  type        = map(any)
}
variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "az_project_in" {}
