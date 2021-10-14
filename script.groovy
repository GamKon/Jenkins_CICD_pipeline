#!/usr/bin/env groovy
def increaseVersion() {
    echo "_____________________________________________________"
    echo "incrementing app version..."
// Increment version in pom.xml    
    sh 'mvn build-helper:parse-version versions:set \
-DnewVersion=\\${parsedVersion.majorVersion}.\\${parsedVersion.minorVersion}.\
\\${parsedVersion.nextIncrementalVersion} versions:commit'
// Parse pom.xml for app version    
    def version_parcer = readFile('pom.xml') =~ '<version>(.+)</version>'
    def version = version_parcer[0][1]
//Add Jenkins build number
    APP_VERSION = "$version-$BUILD_NUMBER"
    APP_IMAGE_FULL_NAME = "$APP_IMAGE_NAME$APP_VERSION"
} 

def buildJar() {
    echo "_____________________________________________________"
    echo "building the jar application..."
// clean - to always have only one jar file
    sh 'mvn clean package'
} 

def buildImage() {
    echo "_____________________________________________________"
    echo "Building&Pushing the docker image..."
//  Push to dockerhub 
    withCredentials([usernamePassword(credentialsId: 'docker_hub_credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh "docker build -t $APP_IMAGE_FULL_NAME ."
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh "docker push $APP_IMAGE_FULL_NAME"
    }
//  Push to local Nexus repo
//temporary turned off to save time
//    withCredentials([usernamePassword(credentialsId: 'nexus_docker_repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
//        sh 'docker build -t nexus-srv:8083/java-maven-app:1.0 .'
//        sh "echo $PASS | docker login -u $USER --password-stdin nexus-srv:8083"
//        sh 'docker push nexus-srv:8083/java-maven-app:1.0'
//    }
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
    echo "waiting for EC2 server to initialize" 
//    sleep(time: 90, unit: "SECONDS")
    echo "EC2 piblic IP: $EC2_PUBLIC_IP"
    
    withCredentials([usernamePassword(credentialsId: 'docker_hub_credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh "echo $PASS | docker login -u $USER --password-stdin"
    }

    def shellCmd = "bash ./docker_ec2_cmds.sh $APP_IMAGE_FULL_NAME $DOCKER_CREDS_USR $DOCKER_CREDS_PSW"
    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"

    sshagent(['key_for_ec2']) {
        sh "scp -o StrictHostKeyChecking=no docker_ec2_cmds.sh ${ec2Instance}:/home/ec2-user/"
        sh "scp -o StrictHostKeyChecking=no docker-compose.yml ${ec2Instance}:/home/ec2-user/"
        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
    }
} 

return this