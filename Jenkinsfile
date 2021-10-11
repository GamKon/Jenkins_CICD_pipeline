pipeline {
    agent any
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
                }
            }
        }
        stage("build image") {
            when {
                expression {
                    BRANCH_NAME == "main"
                }
            }
            steps {
                script {
                    echo "building image"
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
                    echo "deploying"
                }
            }
        }
    }   
}