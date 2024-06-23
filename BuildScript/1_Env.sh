#/bin/bash

export AWS_DEFAULT_REGION='us-east-1'
export AWS_ACCESS_KEY_ID=`sudo aws ssm get-parameters --names "ACCESS_KEY_ID" --query Parameters[0].Value --region $AWS_DEFAULT_REGION | xargs`
export AWS_SECRET_ACCESS_KEY=`sudo aws ssm get-parameters --names "SECRET_ACCESS_KEY" --query Parameters[0].Value --region $AWS_DEFAULT_REGION | xargs`
export TFC_USER_TOKEN=`sudo aws ssm get-parameters --names "TFC_USER_TOKEN" --query Parameters[0].Value --region $AWS_DEFAULT_REGION | xargs`
export ENV="prod"
export GITLAB_PROJECT_ID="<projectid>"
export GITLAB_PROJECT_NAME="automated-soe-image-pipeline"
export GITLAB_PROJECT_PATH="<project-path>"
export GITLAB_PROJECT_URL="<project-url>"

declare -a arr=("ENV" "GITLAB_PROJECT_ID" "GITLAB_PROJECT_NAME" "GITLAB_PROJECT_PATH" "GITLAB_PROJECT_URL")
for i in "${arr[@]}"
do
        echo "$i = ${!i}"
done

export CONTENT_DIRECTORY=Terraform
export UPLOAD_FILE_NAME="./content.tar.gz"
tar -zcvf "$UPLOAD_FILE_NAME" -C "$CONTENT_DIRECTORY" .
