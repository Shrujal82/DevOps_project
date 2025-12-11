pipeline {

agent { label 'slave-agent' }

tools {

}

// Install the Maven version configured as "M3" and add it to the path. maven "M3"

stages {

stage('Build') {

steps {

}

// Get some code from a GitHub repository

git 'https://github.com/Shruja182/DevOps_project.git'

// Run Maven on a Unix agent.

sh "mvn -Dmaven.test.failure.ignore-true clean package"

// To run Maven on a Windows agent, use

// bat "mvn -Dmaven.test.failure.ignore true clean package"

} stage('Build Docker Image') {

steps {

steps {

script {

// Build the Docker image using the Dockerfile in the workspace

sh "docker build -t webapp: 1.0.0."

I }

}

}

}

}

}
