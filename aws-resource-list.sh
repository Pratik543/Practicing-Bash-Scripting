#!/bin/bash

###############################################################
# This script will list all the resources in the AWS account.
# Author: Pratik
# Version: v0.0.1

# Following are the supported AWS services by the script
# 1. EC2
# 2. S3
# 3. IAM
# 4. RDS
# 5. Lambda
# 6. EBS
# 7. ELB
# 8. SQS
# 9. SNS
# 10. KMS
# 11. CloudFront
# 12. CloudWatch
# 13. CloudTrail
# 14. Route 53
# 15. CloudFormation

# Usage: ./aws-resource-list.sh 
# Example: ./aws-resource-list.sh
###############################################################

# Update package lists and add dependencies
sudo apt update -y 

sudo apt install unzip curl -y


curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and try again."

    echo "-------------------------------------------------------"
    echo "Running the following command to install AWS CLI:"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    aws --version
else
    echo "AWS CLI is installed."
fi

# Check if the AWS CLI is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure it and try again."    

    echo "-------------------------------------------------------"
    echo "Running the following command to configure AWS CLI:"
    echo "aws configure
    then provide the following details:
    
    AWS Access Key ID: your_access_key_id
    AWS Secret Access Key: your_secret_access_key
    Default Region: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, eu-west-2, sa-east-1.
    Default Output Format: json, yaml, table, text. 
    "
    aws configure
fi

echo "Option for AWS regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, eu-central-1, eu-west-1, eu-west-2, sa-east-1"
echo "-------------------------------------------------------"
read -p "Enter the AWS region: " aws_region

echo "Option for AWS services: ec2, s3, iam, rds, lambda, ebs, elb, sqs, sns, kms, cloudfront, cloudwatch, cloudtrail, route53, cloudformation"
echo "-------------------------------------------------------"
read -p "Enter the AWS service name: " aws_service

case $aws_service in
    "ec2")
        aws ec2 describe-instances --region $aws_region
        ;;
    "s3")
        aws s3 ls --region $aws_region
        ;;
    "iam")
        aws iam list-users --region $aws_region
        ;;
    "rds")
        aws rds describe-db-instances --region $aws_region
        ;;
    "lambda")
        aws lambda list-functions --region $aws_region
        ;;
    "ebs")
        aws ec2 describe-volumes --region $aws_region
        ;;
    "elb")
        aws elb describe-load-balancers --region $aws_region
        ;;
    "sqs")
        aws sqs list-queues --region $aws_region
        ;;
    "sns")
        aws sns list-topics --region $aws_region
        ;;
    "kms")
        aws kms list-keys --region $aws_region
        ;;
    "cloudfront")
        aws cloudfront list-distributions --region $aws_region
        ;;
    "cloudwatch")
        aws cloudwatch list-metrics --region $aws_region
        ;;
    "cloudtrail")
        aws cloudtrail describe-trails --region $aws_region
        ;;
    "route53")
        aws route53 list-hosted-zones --region $aws_region
        ;;
    "cloudformation")
        aws cloudformation list-stacks --region $aws_region
        ;;
    *)
        echo "Invalid service name. Please choose from the following: ec2, s3, iam, rds, lambda, ebs, elb, sqs, sns, kms, cloudfront, cloudwatch, cloudtrail, route53, cloudformation"
        ;;
esac
