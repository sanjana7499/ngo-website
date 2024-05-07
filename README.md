Step 1: Server Setup

Launch 3 EC2 instances on AWS: Jenkins server, Ansible server, and Docker host.
Install Jenkins on the Jenkins server.
Install Ansible and Docker on the Ansible server.
Add docker host server ip in ansible host file(location: /etc/ansible/hosts)
Set root password in all servers.
Modify the sshd_config file on each server.
Restart the SSH service.
Generate SSH keys and copy targeted server 
Establish passwordless connections between servers.

Step 2: Jenkins Setup

Configure Jenkins.
Install the SSH plugin.
Navigate to "Manage Jenkins" > "System" and add the Ansible and Jenkins server under "SSH Remote Hosts".

Step 3: Build Pipeline

Create a new freestyle project.
Add the GitHub repository URL (forked from the original repo) to the project configuration.
configure github-webhhok
Enable "GitHub hook trigger for GITScm polling" under Build Triggers.
Configure "Send files or execute commands over SSH after the build runs" under Build Environment. Use the command: rsync -avh /var/lib/jenkins/workspace/docker-freestyle-project/* root@<Ansible_Server_IP>:/home/ubuntu.
Add an additional SSH server for Ansible and execute the following commands:
cd /home/ubuntu
docker image build -t $JOB_NAME:v1.$BUILD_ID .
docker image tag $JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:v1.$BUILD_ID
docker image tag $JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:latest
docker image push sachin0110/$JOB_NAME:v1.$BUILD_ID
docker image push sachin0110/$JOB_NAME:latest
docker image rmi $JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:v1.$BUILD_ID sachin0110/$JOB_NAME:latest


Create a Docker playbook (docker.yml) on the Ansible server with the following content:
---
- name: run docker container
  hosts: all
  tasks:
    - name: run container
      shell: docker container run -itd --name sachincontainer -p 9000:80 sachin0110/docker-freestyle-project

Add a "Send build artifacts over SSH" post-build action and include the Ansible server.
Execute the command "ansible-playbook /home/playbook/docker.yml" to run the Docker playbook on the Ansible server.
