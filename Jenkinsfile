pipeline {
    agent slave-agent

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-cred')
        IMAGE_NAME = "your-dockerhub-username/springboot-app"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Shrujal82/DevOps_project.git'
            }
        }

        stage('Build Spring Boot App') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }
    }
}
