#!/bin/bash

# Build docker image
APPSERVER_ECR_REPO="<ecr_repo_arn>"
docker build -t $APPSERVER_ECR_REPO ./yelb-appserver-v2/

# Push image to ECR repo
AWS_CLI_VERSION=$(aws --version 2>&1 | cut -d/ -f2 | cut -d. -f1)

if [[ ${AWS_CLI_VERSION} == 1 ]]
then
  $(aws ecr get-login --no-include-email)
else
  aws ecr get-login-password | docker login --username AWS --password-stdin $APPSERVER_ECR_REPO
fi


docker push  $APPSERVER_ECR_REPO:latest