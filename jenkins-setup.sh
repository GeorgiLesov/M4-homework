#!/bin/bash

echo "* Add any prerequisites ..."
sudo apt-get update
sudo apt-get install fontconfig openjdk-11-jre -y

echo "* Download the Jenkins key"
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "* Create record for the repository "
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]  https://pkg.jenkins.io/debian binary/ | sudo tee  /etc/apt/sources.list.d/jenkins.list > /dev/null


sudo apt-get update
sudo apt-get install jenkins -y