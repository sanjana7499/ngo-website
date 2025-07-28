DevOps Project using GitHub , Jenkins, Ansible , Docker ,web server


create dockerfile in GitHub 

FROM nginx:latest
COPY . /usr/share/nginx/html
RUN apt-get update
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


create 3 instances using ubuntu image

Jenkins server
ansible server
web server

Go To Jenkins server
Deploying Jenkins path: /var/lib/Jenkins/workspace

sudo su
cd /

......install java

sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -version
openjdk version "21.0.3" 2024-04-16
OpenJDK Runtime Environment (build 21.0.3+11-Debian-2)
OpenJDK 64-Bit Server VM (build 21.0.3+11-Debian-2, mixed mode, sharing)

......install Jenkins

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install Jenkins

......Then we need to enable start Jenkins

systemctl enable Jenkins
systemctl start Jenkins

......check Jenkins is active or not

systemctl status Jenkins

......Then we need to generate public & Private key

ssh-keygen

cd /
cd ~
ls -a
~/.ssh ----list public & private key path here.. like: authorized_keys  id_ed25519  id_ed25519.pub

....Then go to authorized_key

vim authorized_key
put here Jenkins public key like:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG6EfEmwEVI242Ti+4kfDev9DwMDgrCJc8BqWYJUOIsa root@jenkins

save & exit file

....Then go to this path

/etc/ssh/
vi sshd_config ---- here doing changes 

like:
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes

......after that restart ssh

systemctl restart ssh

.......generate password of Jenkins gui

copy Jenkins public ip and go to browser like:13.233.119.120:8080
8080 is a Jenkins default port
then copy path of jenkin gui
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
go to Jenkins server for pass
cat sudo cat /var/lib/jenkins/secrets/initialAdminPassword ----generate here pass
this pass is paste on Jenkins ui and start jenkins


......when we need to check connection between Jenkins to ansible 

ssh root@13.233.119.120 ----ansible private ip & also public ip used

here when deploy project workspace folder is automatically created 
...............................................................................................................................................
...............................................................................................................................................
...............................................................................................................................................

Go To ansible server
Deploying ansible path: /opt/

sudo su
cd /

......install ansible

sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

......Then we need to generate public & Private key

ssh-keygen

~
ls -a
~/.ssh ----list public & private key path here.. like: authorized_keys  id_ed25519  id_ed25519.pub

....Then go to authorized_key

vim authorized_key
put here Jenkins public key like:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG6EfEmwEVI242Ti+4kfDev9DwMDgrCJc8BqWYJUOIsa root@jenkins
also put ansible public key like:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEqmxfFwSVItqVTA17lmNcndpzDUV29TRK9G2P+slTg root@ansible

save & exit file

....Then go to this path

/etc/ssh/
vi sshd_config ---- here doing changes

like:
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes

......after that restart ssh

systemctl restart ssh

......Then go to ansible path

vim /etc/ansible/hosts

[web] ----here write web server private ip
172.31.32.208

......create playbook.yml

mkdir sourcecode
cd sourcecode
vim playbook.yml

- hosts: all
  become: true
  tasks:
    - name: Remove old container (if exists)
      shell: docker rm -f max-container
      ignore_errors: yes

    - name: Pull latest image
      shell: docker pull sanjana1001/max:latest

    - name: Run new container
      shell: docker run -itd --name max-container -p 9001:80 sanjana1001/max:latest

 save exit

......install docker

apt install docker.io

.......docker login

docker login 
copy code and go to url and login with code


......when we need to check connection between ansible to web 

ssh root@13.233.119.120 ----web private ip & also public ip used

here when deploy project automatically project push on /opt folder 

...............................................................................................................................................
...............................................................................................................................................
...............................................................................................................................................
Go To web server
Deploying web path: /var/www/html

sudo su
cd /

......install apache2

apt update
apt upgrade
apt install apache2

.......start & enable apache2

systemctl enable apache2
systemctl start apache2
systemctl status apache2

...... Then go to

~/.ssh ----list public & private key path here.. like: authorized_keys  

....Then go to authorized_key

vim authorized_key

put ansible public key like:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEqmxfFwSVItqVTA17lmNcndpzDUV29TRK9G2P+slTg root@ansible

save & exit file


....Then go to this path

/etc/ssh/
vi sshd_config ---- here doing changes

like:
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes

......after that restart ssh

systemctl restart ssh

......install docker

apt install docker.io

.......docker login

docker login 
copy code and go to url and login with code


......Then go to web path

cd /var/www/html ----here project deploying files 

here when deploy project automatically project push on /var/www/html path

...............................................................................................................................................
...............................................................................................................................................
...............................................................................................................................................

....integration of GitHub to Jenkins....


first go to GitHub settings
choose webhook and click on add webhook
Payload URL * ---here put Jenkins url like: ---0.0.0.0:8080
Content type * choose: application/json
secret : ----here put token of Jenkins
goto Jenkins setting click on add token copy token and paste on secret section
apply & save token first then save webhook
http://13.126.233.78:8080/github-webhook/ (push)----show like this  webhook is created properly or not
then go to Jenkins
install plugins ---- publish over ssh , pipeline view stage

....now build project on Jenkins UI...

goto manage Jenkins
click on system and scroll until last
click SSH Servers

Name:jenkins
Hostname: ---put here Jenkins public ip
Username:root
key:-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBuhHxJsBFSNuNk4vuJHw3r/Q8DA4KwiXPAalmCVDiLGgAAAJB60w+0etMP
tAAAAAtzc2gtZWQyNTUxOQAAACBuhHxJsBFSNuNk4vuJHw3r/Q8DA4KwiXPAalmCVDiLGg
AAAEAGrozfXPJ6KAbnuusa9SyXHkqQDzuBpzepJ7yyksI2EW6EfEmwEVI242Ti+4kfDev9
DwMDgrCJc8BqWYJUOIsaAAAADHJvb3RAamVua2lucwE=
-----END OPENSSH PRIVATE KEY-----

Name:ansible
Hostname: ---put here ansible public ip
Username:root
key:-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBuhHxJsBFSNuNk4vuJHw3r/Q8DA4KwiXPAalmCVDiLGgAAAJB60w+0etMP
tAAAAAtzc2gtZWQyNTUxOQAAACBuhHxJsBFSNuNk4vuJHw3r/Q8DA4KwiXPAalmCVDiLGg
AAAEAGrozfXPJ6KAbnuusa9SyXHkqQDzuBpzepJ7yyksI2EW6EfEmwEVI242Ti+4kfDev9
DwMDgrCJc8BqWYJUOIsaAAAADHJvb3RAamVua2lucwE=
-----END OPENSSH PRIVATE KEY-----

apply & save
.......................................................................

click new item ---make sure job name always in lower case
put project name click on freestyle project and click ok
description:  THIS IS MY FIRST docker NGO-PROJECT DEPLOYMENT
choose GitHub project paste here GitHub url
Source Code Management :   choose git ,   paste here GitHub project url
check GitHub branch name 
Triggers: choose GitHub hook trigger for GITScm polling
click on build step : choose Send files or execute commands over SSH
Name: Jenkins  EXEC COOMMAND:rsync -avh "/var/lib/jenkins/workspace/NGO-FIRST DEPLOY/" root@172.31.1.41:/opt  ---here put ansible private ip
also add ansible 
click on build step : choose Send files or execute commands over SSH
Name: Jenkins  EXEC COOMMAND: ansible-playbook /sourcecode/playbook.yml
now apply & save
click on build now
Deploying Jenkins path: /var/lib/Jenkins/workspace
Deploying ansible path: /opt/
Deploying web path: /var/www/html
 
check project on browser

web public ip

...............................................................................
...............................................................................
...............................................................................

.....create project using pipeline script........

create job click on new item --make sure job name always in lower case
put project name click on pipeline project and click ok
description:  THIS IS MY FIRST docker NGO-PROJECT pipeline DEPLOYMENT
choose GitHub project paste here GitHub url
Triggers: choose GitHub hook trigger for GITScm polling
pipeline script
EX:
pipeline {
    agent any

    stages {
        stage('github Integration') {
            steps {
                git branch: 'main', url: 'https://github.com/sanjana7499/ngo-website.git'
                echo 'github integration successfully done'
            }
        }
        stage('Build') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'jenkins', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''rsync -avh "/var/lib/jenkins/workspace/max/" root@172.31.1.41:/opt
''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                echo 'Build successfully done'
            }
        }
        stage('Docker Build & Push') {
            steps {
                echo '==== Docker Build & Push ===='
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible', transfers: [sshTransfer(
                    execCommand: '''set -x
cd /opt

echo "🔧 Building Docker image..."
docker build -t $JOB_NAME:v1.$BUILD_ID .

echo "📦 Tagging Docker image..."
docker tag $JOB_NAME:v1.$BUILD_ID sanjana1001/$JOB_NAME:v1.$BUILD_ID
docker tag $JOB_NAME:v1.$BUILD_ID sanjana1001/$JOB_NAME:latest

echo "☁️ Pushing Docker image to DockerHub..."
docker push sanjana1001/$JOB_NAME:v1.$BUILD_ID
docker push sanjana1001/$JOB_NAME:latest

echo "🧹 Cleaning up local Docker images..."
docker rmi $JOB_NAME:v1.$BUILD_ID
docker rmi sanjana1001/$JOB_NAME:v1.$BUILD_ID
docker rmi sanjana1001/$JOB_NAME:latest

echo "✅ Docker build & push complete"
''', 
                    execTimeout: 120000,
                    cleanRemote: false,
                    sourceFiles: ''
                )])])
                echo '✅ Docker image build and pushed'
            }
        }
        stage('deploy') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''ansible-playbook /sourcecode/docker.yml
''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                echo 'deploy website successfully'
            }
        }
    }
}


Then apply & save pipeline script 

click on build now
Deploying Jenkins path: /var/lib/Jenkins/workspace
Deploying ansible path: /opt/
Deploying web path: /var/www/html


first go to docker hub and create repository using job name ---same as job name
Then....
go to docker hub and check docker image pull or not there when we build project


 
check project on browser

web public ip
...................................................................................................
...................................................................................................




















