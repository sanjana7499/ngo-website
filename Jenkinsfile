pipeline {
    agent any

    stages {
        stage('git fetch') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sachirau/ngo-website.git']]])
            }
        }
        stage('build artifact') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'jenkins', 
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false, 
                                    excludes: '', 
                                    execCommand: 'rsync -avh /var/lib/jenkins/workspace/docker-pipeline-project/* root@172.31.25.31:/home/ubuntu', 
                                    execTimeout: 120000, 
                                    flatten: false, 
                                    makeEmptyDirs: false, 
                                    noDefaultExcludes: false, 
                                    patternSeparator: '[, ]+', 
                                    remoteDirectory: '', 
                                    remoteDirectorySDF: false, 
                                    removePrefix: '', 
                                    sourceFiles: '')
                            ], 
                            usePromotionTimestamp: false, 
                            useWorkspaceInPromotion: false, 
                            verbose: true
                        ),
                        sshPublisherDesc(
                            configName: 'ansible', 
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false, 
                                    excludes: '', 
                                    execCommand: '''
                                        cd /home/ubuntu
                                        docker image build -t $JOB_NAME:v1.$BUILD_ID .
                                        docker image tag $JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:v1.$BUILD_ID
                                        docker image tag $JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:latest
                                        docker image push sachin0110/$JOB_NAME:v1.$BUILD_ID
                                        docker image push sachin0110/$JOB_NAME:latest
                                        docker image rmi $JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:latest
                                    ''', 
                                    execTimeout: 120000, 
                                    flatten: false, 
                                    makeEmptyDirs: false, 
                                    noDefaultExcludes: false, 
                                    patternSeparator: '[, ]+', 
                                    remoteDirectory: '', 
                                    remoteDirectorySDF: false, 
                                    removePrefix: '', 
                                    sourceFiles: '')
                            ], 
                            usePromotionTimestamp: false, 
                            useWorkspaceInPromotion: false, 
                            verbose: false
                        )
                    ]
                )
            }
        }
        stage('post build action') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'ansible', 
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false, 
                                    excludes: '', 
                                    execCommand: 'ansible-playbook /home/playbook/docker.yml', 
                                    execTimeout: 120000, 
                                    flatten: false, 
                                    makeEmptyDirs: false, 
                                    noDefaultExcludes: false, 
                                    patternSeparator: '[, ]+', 
                                    remoteDirectory: '', 
                                    remoteDirectorySDF: false, 
                                    removePrefix: '', 
                                    sourceFiles: '')
                            ], 
                            usePromotionTimestamp: false, 
                            useWorkspaceInPromotion: false, 
                            verbose: false
                        )
                    ]
                )
            }
        }
    }
}
