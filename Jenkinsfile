pipeline {
    agent dev
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
        stage("deploy") {
            when {
                expression {
                    BRANCH_NAME == "main"
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