#!/usr/bin/env groovy
def APP_IMAGE_NAME = "java-maven-app:1.0"

def buildJar() {
    echo "_____________________________________________________"
    echo "building the jar application..."
    sh 'mvn package'
} 

def buildImage() {
    echo "_____________________________________________________"
    echo "Building&Pushing the docker image..."
//  Push to dockerhub 
//temporary turned off to save time
    withCredentials([usernamePassword(credentialsId: 'docker_hub_credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t gamkon61/gamkon-repo:jma-1.0 .'
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh 'docker push gamkon61/gamkon-repo:jma-1.0'
    }
//  Push to local Nexus repo
    withCredentials([usernamePassword(credentialsId: 'nexus_docker_repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t nexus-srv:8083/java-maven-app:1.0 .'
        sh "echo $PASS | docker login -u $USER --password-stdin nexus-srv:8083"
        sh 'docker push nexus-srv:8083/java-maven-app:1.0'
    }
} 

def runTerraform() {
    dir("terraform") {
        sh "terraform init"
        sh "terraform apply --auto-approve"
        EC2_PUBLIC_IP = sh(
            script: 'terraform output Server-1-public-IP',
            returnStdout: true
        ).trim()
    }
}

def deployApp() {
    echo "_____________________________________________________"
    echo 'deploying the application to EC2...'
/*    echo "EC2 piblic IP: $EC2_PUBLIC_IP"*/
    def docker_command = "docker run -p 8080:8080 -d gamkon-repo:jma-1.0"
// ${APP_IMAGE_NAME}"   
// ${EC2_PUBLIC_IP}
    sshagent(credentials: ['key_for_ec2']) {
        sh "ssh -o StrictHostKeyChecking=no ec2-user@35.182.226.1 ${docker_command}"
    }
} 

return this