pipeline {
    agent { label 'slave-agent' }

    environment {
        APP_NAME = "myapp"
        DOCKER_USER = "shrujal"     // change this
        IMAGE_TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
    }
	tools {
        jdk 'JAVA21'
        maven 'M3'
    }
    stages {

        stage('Checkout') {
            steps {
                checkout scm   // ensures .git folder exists
            }
        }

        stage('Build JAR') {
            steps {
                sh "mvn clean package -DskipTests"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                       docker build -t ${DOCKER_USER}/${APP_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            when {
                expression { return env.BRANCH_NAME == "main" || env.BRANCH_NAME == "master" }
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        sh "docker push ${DOCKER_USER}/${APP_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Build & Docker Image Created Successfully"
        }
        failure {
            echo "Build Failed"
        }
    }
}
