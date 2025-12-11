pipeline {
    agent { label 'slave-agent' }
	triggers {
        githubPush()
    }
	tools {
        jdk 'JAVA21'
        maven 'M3'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Shrujal82/DevOps_project.git'
            }
        }

        stage('Build Spring Boot App') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
