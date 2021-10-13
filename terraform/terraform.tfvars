#region_project_in = "us-east-1"
#az_project_in     = "us-east-1a"

ip_for_ssh_inbound_connection = "0.0.0.0/0"
ports_to_open         = ["80", "443", "8080"]
#public_key_location             = "~/.ssh/key-for-ec2.pem"
//public_key_location   = "~/.ssh/id_rsa.pub"
//private_key_location  = "~/.ssh/id_rsa"
bootstrap_script_file = "user_data.sh"
tfstate_s3_bucket     = "terraform-state-files-gamkon"

instance_type_webserver = "t2.micro"
ami_name                = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
vpc_cidr_block          = "192.168.0.0/16"
subnet_cidr_block       = "192.168.1.0/24"
env_prefix              = "Dev"
project_name            = "Jenkins-CICD-pipeline"
project_owner           = "GamKon"
#project_environment     = "PROD"


tags_common = {
  Owner       = "GamKon"
  Project     = "Jenkins-CICD-pipeline"
#  Environment = "Dev"
}
