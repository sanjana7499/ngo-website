pipeline {
    agent any

    stages {
        stage('code fetch') {
            steps {
                checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '**']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub', url: 'https://github.com/sachirau/ngo-website.git']])
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
