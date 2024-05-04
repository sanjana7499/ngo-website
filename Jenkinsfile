pipeline {
    agent any

    stages {
        stage('code fetch') {
            steps {
                checkout scmGit(branches: [[name: '**']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sachirau/ngo-website.git']])
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
