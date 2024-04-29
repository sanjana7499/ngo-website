pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Clone the repository from GitHub
                git 'https://github.com/sachirau/ngo-website.git'
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
                script {:
                    Docker run -itd -p 80:80 Sachin
                }
            }
        }
    }
}
