#!/bin/bash 
#run as bash rundeckscript.sh
IP=$(curl https://ipinfo.io/ip)
sudo mkdir -p /home/tp0265/rundeck/server/data
sudo docker cp rundeck:/home/rundeck/server/data/ /home/tp0265/rundeck/server/
sudo docker container rm rundeck
PREFIX="http://"
sudo docker run -p 80:4440 --detach  -e RUNDECK_GRAILS_URL=$PREFIX$IP --name rundeck -v data:/home/rundeck/server/data -v /home/tp0265/.ssh:/home/rundeck/.ssh rundeck/rundeck:3.2.6
sudo docker cp /home/tp0265/rundeck/server/data/ rundeck:/home/rundeck/server
sudo docker exec -u 0 rundeck chmod -R 757 /home/rundeck/.ssh
sudo docker exec -u 0 rundeck chmod -R 757 /home/rundeck/server/data
