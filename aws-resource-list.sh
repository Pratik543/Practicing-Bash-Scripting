#!/bin/bash

###############################################################
# This script will list all the resources in the AWS account.
# Author: Pratik Gupta
# Version: v0.0.2
#
# Changelog:
# v0.0.2 - Replaced read with select for interactive menu and added select menu for output format (json, table, text and yaml).
###############################################################

# Helper functions
print_red() {
  echo -e "\e[31m$1\e[0m"
}

print_green() {
  echo -e "\e[32m$1\e[0m"
}

print_white() {
  echo -e "\e[37m$1\e[0m"
}

# --- AWS Region Selection ---
print_green "Please select an AWS region:"
regions=("us-east-1" "us-east-2" "us-west-1" "us-west-2" "ap-south-1" "ap-northeast-1" "ap-northeast-2" "ap-northeast-3" "ap-southeast-1" "ap-southeast-2" "ca-central-1" "eu-central-1" "eu-west-1" "eu-west-2" "eu-west-3" "eu-north-1" "sa-east-1" "Quit")
PS3="Enter the number for the AWS region: "

select region_choice in "${regions[@]}"; do
  if [[ " ${regions[*]} " =~ " ${region_choice} " ]]; then
    if [ "$region_choice" == "Quit" ]; then
      print_red "Exiting script."
      exit 0
    fi
    aws_region=$region_choice
    print_green "You have selected region: $aws_region"
    break
  else
    print_red "Invalid option. Please try again."
  fi
done

print_white "<------------------------------------------------------------------------------------------------>"
echo ""

# --- AWS Service Selection ---
print_green "Please select the AWS service to list resources for:"
services=("ec2" "s3" "iam" "rds" "lambda" "ebs" "elb" "sqs" "sns" "kms" "cloudfront" "cloudwatch" "cloudtrail" "route53" "cloudformation" "Quit")
PS3="Enter the number for the AWS service: "

select service_choice in "${services[@]}"; do
  if [[ " ${services[*]} " =~ " ${service_choice} " ]]; then
    if [ "$service_choice" == "Quit" ]; then
      print_red "Exiting script."
      exit 0
    fi
    aws_service=$service_choice
    print_green "You have selected service: $aws_service"
    break
  else
    print_red "Invalid option. Please try again."
  fi
done

print_white "<------------------------------------------------------------------------------------------------>"
echo ""

# --- AWS CLI Output Format Selection ---
print_green "Please select the output format:"
formats=("json" "table" "text" "yaml" "Quit")
PS3="Enter the number for the output format: "

select format_choice in "${formats[@]}"; do
  if [[ " ${formats[*]} " =~ " ${format_choice} " ]]; then
    if [ "$format_choice" == "Quit" ]; then
      print_red "Exiting script."
      exit 0
    fi
    output_format=$format_choice
    print_green "You have selected format: $output_format"
    break
  else
    print_red "Invalid option. Please try again."
  fi
done

print_white "-------------------------------------------------------"
echo ""
print_green "Fetching resources for '$aws_service' in region '$aws_region' with '$output_format' format..."
print_white "<------------------------------------------------------------------------------------------------>"

# --- Execute AWS CLI command based on selection ---
# The command is built and then evaluated to handle the conditional pipe to fx
command_base="aws $aws_service"

# Add the appropriate subcommand for the selected service
case $aws_service in
    "ec2") command_base="$command_base describe-instances" ;;
    "s3") command_base="$command_base ls" ;;
    "iam") command_base="$command_base list-users" ;;
    "rds") command_base="$command_base describe-db-instances" ;;
    "lambda") command_base="$command_base list-functions" ;;
    "ebs") command_base="aws ec2 describe-volumes" ;; # EBS uses the ec2 service command
    "elb") command_base="$command_base describe-load-balancers" ;;
    "sqs") command_base="$command_base list-queues" ;;
    "sns") command_base="$command_base list-topics" ;;
    "kms") command_base="$command_base list-keys" ;;
    "cloudfront") command_base="$command_base list-distributions" ;;
    "cloudwatch") command_base="$command_base list-metrics" ;;
    "cloudtrail") command_base="$command_base describe-trails" ;;
    "route53") command_base="$command_base list-hosted-zones" ;;
    "cloudformation") command_base="$command_base list-stacks" ;;
esac

# Construct the full command with region and output format
full_command="$command_base --region $aws_region --output $output_format"

# Only pipe to fx if the output is json, otherwise just run the command
if [ "$output_format" == "json" ]; then
    eval "$full_command | fx"
else
    eval "$full_command"
fi

print_white "<------------------------------------------------------------------------------------------------>"
