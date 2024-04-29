pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Clone the repository from GitHub
                git url: 'https://github.com/sachirau/ngo-website.git', 
                    branch: 'main',
                    changelog: false,
                    poll: false
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run Docker container using nginx:latest image, mapping port 80 to 80
                script {
                    docker.image('nginx:latest').run('-p 80:80')
                }
            }
        }
    }
}
