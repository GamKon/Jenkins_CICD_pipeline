#!/usr/bin/env groovy
pipeline {
    agent { 
        label "dev"
    }
    tools {
        maven 'Maven'
    }
    environment {
        BRANCH_TO_DEPLOY = "feature/deploy_to_AWS"
        APP_IMAGE_NAME = "gamkon61/gamkon-repo:jma-1.0"
        EC2_PUBLIC_IP = "35.183.109.84"

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
        stage("build_jar") {
            when {
                expression {
                    BRANCH_NAME != BRANCH_TO_DEPLOY
                }
            }
            steps {
                script {
//                    echo "buildJar!!!!!!!!!!!!!"
                    ext_gv_scripts.buildJar()
                }
            }
        }
        stage("build_docker_image") {
            when {
                expression {
                    BRANCH_NAME != BRANCH_TO_DEPLOY
                }
            }
            steps {
                script {
//                    echo "buildImage!!!!!!!!!!!!!"
                    ext_gv_scripts.buildImage()
                }
            }
        }
        stage("provision_server") {
            when {
               expression {
                    BRANCH_NAME == BRANCH_TO_DEPLOY
                }
            }
            environment {
                AWS_ACCESS_KEY_ID = credentials("jenkins-aws-access-key-id")
                AWS_SECRET_ACCESS_KEY = credentials("jenkins-aws-secret-access-key-id")
                TF_VAR_project_environment = "Test"
                TF_VAR_region_project_in   = "ca-central-1"
                TF_VAR_az_project_in       = "ca-central-1a"
            }
            steps {
                script {
                    ext_gv_scripts.runTerraform()
                }
            }
        }
        stage("deploy_app") {
            when {
                expression {
                    BRANCH_NAME == BRANCH_TO_DEPLOY
                }
            }
            steps {
                script {
                    ext_gv_scripts.deployApp()                    
                }
            }
        }
    }   
}