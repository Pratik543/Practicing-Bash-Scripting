#!/bin/bash

###############################################################
# This script will install the AWS CLI.
# Author: Pratik
# Version: v0.0.1

# Helper functions
print_red() {
  echo -e "\e[31m$1\e[0m"
}

print_green() {
  echo -e "\e[32m$1\e[0m"
}


# Update package lists and add dependencies
print_green "Updating package lists..."
sudo apt update -y 

print_green "Installing unzip and curl..."
sudo apt install unzip curl -y

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    print_red "AWS CLI is not installed. Please install it and try again."

    # white line separator
    echo -e "\e[31m------------------------------------------------\e[0m"
    print_green "Running the following command to install AWS CLI:"
    print_green "Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    aws --version
else
    print_green "AWS CLI is installed."
fi

# Check if the AWS CLI is configured
if [ ! -d ~/.aws ]; then
    print_red "AWS CLI is not configured. Please configure it and try again."    

    # white line separator
    echo -e "\e[31m------------------------------------------------\e[0m"
    print_green "Running the following command to configure AWS CLI:"
    print_green "aws configure
    then provide the following details:
    
    AWS Access Key ID: your_access_key_id
    AWS Secret Access Key: your_secret_access_key
    Default Region: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, eu-west-2, sa-east-1.
    Default Output Format: json, yaml, table, text. 
    "
    aws configure

else
    print_green "AWS CLI is configured."
fi

print_green "------------------Setup complete-----------------."