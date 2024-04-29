pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Clone the repository from GitHub
                git url: 'https://github.com/sachirau/ngo-website.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile in the repository
                script {
                    docker build -t Sachin:latest
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run Docker container mapping port 80 to a random port
                script {
                    docker run -itd -p 80:80 Sachin
                }
            }
        }
    }
}
