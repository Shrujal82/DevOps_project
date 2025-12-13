pipeline {
    agent { label 'slave-agent' }

    environment {
        APP_NAME = "webapp"
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
					   docker tag ${DOCKER_USER}/${APP_NAME}:${IMAGE_TAG} ${DOCKER_USER}/${APP_NAME}:latest
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
						sh "docker push ${DOCKER_USER}/${APP_NAME}:latest"
                    }
                }
            }
        }
		stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    # Update image in YAML
                    sed -i "s|image: .*|image: ${DOCKER_USER}/${APP_NAME}:latest|g" k8s/java-app.yaml
                    
                    # Deploy
                    kubectl apply -f k8s/java-app.yaml
                    
                    # Wait for rollout (Java apps take ~1-2min to start)
                    kubectl rollout status deployment/java-app --timeout=300s
                    
                    echo "Java App deployed!"
                    echo "Access at: http://$(curl -s ifconfig.me):30080"
                '''
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
