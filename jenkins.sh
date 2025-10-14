#!/bin/bash

# Exit on any error
set -e

echo "🔧 Updating system packages..."
sudo yum update -y

echo "📦 Adding Jenkins repo..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "📦 Installing Jenkins..."
sudo yum install jenkins -y

sudo mkdir -p /var/lib/jenkins
sudo mkdir -p /var/log/jenkins
sudo mkdir -p /var/cache/jenkins

echo "🔐 Setting permissions for Jenkins..."
sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo chown -R jenkins:jenkins /var/log/jenkins
sudo chown -R jenkins:jenkins /var/cache/jenkins

echo "🚀 Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "🧱 Opening firewall port 8080..."
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload

echo "✅ Jenkins installed and started successfully."
echo "🔑 Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

curl ifconfig.me
echo "🌐 Access Jenkins at: http://<your-server-ip>:8080"
