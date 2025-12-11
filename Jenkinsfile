pipeline {
    agent slave-agent

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
