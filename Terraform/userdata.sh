#!/bin/bash
sudo yum install jq -y
##Fetching gitlab password from parameter store
GITLAB_PWD=`aws ssm get-parameter --name "gitlab-runner_password" --region 'us-east-1' | jq .Parameter.Value | xargs`

##Set the password for ec2-user
PASSWORD_HASH=$(openssl passwd -1 $GITLAB_PWD)
sudo usermod --password "$PASSWORD_HASH" ec2-user

## Create gitlab-runner user and set password
USER='gitlab-runner'
sudo useradd -m -u 1001 -p $(openssl passwd -1 $GITLAB_PWD) $USER

##Copy the Gitlab SSH Key to gitlab-runner server
sudo mkdir /home/$USER/.ssh
sudo chmod 700 /home/$USER/.ssh
Ansible_SSH_Key=`aws ssm get-parameter --name "Ansible-SSH-Key" --region 'us-east-1' | jq .Parameter.Value | xargs`
sudo echo $Ansible_SSH_Key > /home/$USER/.ssh/authorized_keys
sudo chown -R $USER:$USER /home/$USER/.ssh/
sudo chmod 600 /home/$USER/.ssh/authorized_keys
sudo echo "StrictHostKeyChecking no" >> /home/$USER/.ssh/config
sudo echo "$USER  ALL=(ALL) NOPASSWD  : ALL" > /etc/sudoers.d/00-$USER
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/; s/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd
sleep 40