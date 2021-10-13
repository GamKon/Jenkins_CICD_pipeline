pipeline {
    agent { 
        label "dev"
    }
    tools {
        maven 'Maven'
    }
    stages {
        stage("init") {
            steps {
                script {
                    echo "$BRANCH_NAME initializing...."
                        ext_gv_scripts = load "script.groovy"
                }
            }
        }
        stage("build jar") {
            steps {
                script {
                    ext_gv_scripts.buildJar()
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
                    ext_gv_scripts.buildImage()
                }
            }
        }
        stage("provision server") {
//            when {
//               expression {
//                    BRANCH_NAME == "main"
//                }
//            }
            environment {
                AWS_ACCESS_KEY_ID = credentials("jenkins-aws-access-key-id")
                AWS_SECRET_ACCESS_KEY = credentials("jenkins-aws-secret-access-key-id")
                TF_VAR_project_environment = "Test"
            }
            steps {
                script {
//                    ext_gv_scripts.deployApp()
                    dir("terraform") {
                        sh "echo $AWS_ACCESS_KEY_ID     -----     $AWS_SECRET_ACCESS_KEY"
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP = sh(
                            script: "terraform output Server-1-public-IP"
//                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }
        stage("deploy app") {
            when {
                expression {
                    BRANCH_NAME == "main"
                }
            }
            steps {
                script {
                    echo "_____________________________________________________"
                    echo 'deploying the application to EC2...'
                    echo "EC2 piblic IP: $EC2_PUBLIC_IP"
                }

            }
        }
    }   
}