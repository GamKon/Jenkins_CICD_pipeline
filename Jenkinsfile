pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    stages {
        stage("init") {
            steps {
                script {
                    echo "$BRANCH_NAME initializing...."
                }
            }
        }
        stage("build jar") {
            steps {
                script {
                    echo "building jar"
                    sh 'mvn package'
                }
            }
        }
        stage("build docker image") {
            when {
                expression {
                    BRANCH_NAME == "main"
                }
            }
            steps {
                script {
                    echo "building docker image"
                    withCredentials([usernamePassword(credentialsId: 'docker_hub_credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t gamkon61/gamkon-repo:jma-1.0 .'
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh 'docker push gamkon61/gamkon-repo:jma-1.0'
                    }
                    withCredentials([usernamePassword(credentialsId: 'nexus_docker_repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t nexus-srv:8083/java-maven-app:1.0 .'
                        sh "echo $PASS | docker login -u $USER --password-stdin nexus-srv:8083"
                        sh 'docker push nexus-srv:8083/java-maven-app:1.0'
                    }
                }
            }
        }


        nexus-srv:8082
        stage("deploy") {
            when {
                expression {
                    BRANCH_NAME == "main"
                }
            }
            steps {
                script {
                    echo "deploying"
                }
            }
        }
    }   
}