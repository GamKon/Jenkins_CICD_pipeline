terraform {
  backend "s3" {
    bucket = "terraform-state-files-gamkon"
    key    = "Jenkins-CICD-pipeline/terraform.tfstate"
    region = "us-east-1"
  }
}

module "networking" {
  source                        = "./modules/networking"
  ports_to_open                 = var.ports_to_open
  ip_for_ssh_inbound_connection = var.ip_for_ssh_inbound_connection
  project_name                  = var.project_name
  project_environment           = var.project_environment
  tags_common                   = merge(var.tags_common, { Environment = "${var.project_environment}" })
  vpc_cidr_block                = var.vpc_cidr_block
  subnet_cidr_block             = var.subnet_cidr_block
  az_project_in                 = var.az_project_in
}

module "ec2_webserver" {
  source                  = "./modules/webserver"
  //public_key_location     = var.public_key_location
  //private_key_location    = var.private_key_location
  instance_type_webserver = var.instance_type_webserver
  az_project_in           = var.az_project_in
  bootstrap_script_file   = var.bootstrap_script_file
  project_name            = var.project_name
  project_environment     = var.project_environment
  tags_common             = merge(var.tags_common, { Environment = "${var.project_environment}" })
  vpc_security_group_ids  = [module.networking.security_group.id]
  subnet_id               = module.networking.subnet_1.id
  ami_name                = var.ami_name
}
