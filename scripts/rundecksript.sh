#!/bin/bash 
#run as sudo bash rundeckscript.sh [user]
IP=$(curl https://ipinfo.io/ip)
USER=$1
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa -C $USER 2>/dev/null <<< y >/dev/null
KEY=$(cat ~/.ssh/id_rsa.pub)
curl -fsSL get.docker.com | bash
sudo usermod -aG docker $USER
PREFIX="http://"
echo $PREFIX
sudo docker run -p 80:4440 --detach  -e RUNDECK_GRAILS_URL=$PREFIX$IP --name rundeck -v data:/home/rundeck/server/data -v /home/$USER/.ssh:/home/rundeck/.ssh rundeck/rundeck:3.2.6
sudo docker exec -u 0 rundeck chmod -R 757 /home/rundeck/.ssh
echo $KEY
