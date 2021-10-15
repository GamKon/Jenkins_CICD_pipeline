## Jenkins CI/CD multibranch pipeline
### Author: GamKon
Jenkins pipeline:
    Builds Java-Maven Docker container app. 
    Pushes the image to Nexus and DockerHub repositories.
    Uses Terraform to provide infrastructure on AWS
    Deploys the app on EC2, removing old images.
    App version auto increase and push back to GitHub from Jenkins
