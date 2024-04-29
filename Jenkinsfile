pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Clone the repository from GitHub
                git url: 'https://github.com/sachirau/ngo-website.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile in the repository
                script {
                    docker.build('Sachin:latest', '-f Dockerfile .')
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run Docker container mapping port 80 to a random port
                script {
                    docker.image('Sachin:latest').run('-p 80:80')
                }
            }
        }
    }
}
