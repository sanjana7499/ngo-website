pipeline {
    agent any

    stages {
        stage('code fetch') {
            steps {
                checkout([$class: 'GitSCM', 
                          branches: [[name: '*/main']], 
                          doGenerateSubmoduleConfigurations: false, 
                          extensions: [], 
                          userRemoteConfigs: [[credentialsId: 'GitHub', url: 'https://github.com/sachirau/ngo-website.git']]])
                echo 'fetch successful'
            }
        }
        stage('build') {
            steps {
                echo 'build successful'
            }
        }
    }
}
