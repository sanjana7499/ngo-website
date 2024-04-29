pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Clone the repository from GitHub
                git 'https://github.com/your_username/your_repository.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile in the repository
                script {
                    docker.build('your_image_name:latest', '-f Dockerfile .')
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run Docker container mapping port 80 to a random port
                script {
                    docker.image('your_image_name:latest').run('-p 80:80')
                }
            }
        }
    }
}