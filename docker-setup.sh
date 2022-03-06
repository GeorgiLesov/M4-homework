#!/bin/bash

echo "* Add any prerequisites ..."
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release git

echo "* Add Docker repository and key ..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "* Install Docker ..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.

echo "* Install Docker compose*"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "* Postinstalation ..."

sudo usermod -aG docker vagrant

sudo useradd jenkins
sudo usermod -aG docker jenkins
sudo usermod -s /bin/bash jenkins 
echo -e "Password1\nPassword1" | sudo passwd jenkins
echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins
sudo chmod -R 440 /etc/sudoers.d/jenkins

sudo mkdir -p /home/jenkins/M4
sudo chown jenkins:jenkins /home/jenkins/M4

sudo service jenkins restart
