#!/bin/bash

# The script backups up jenkins data on a remote server

script_name=$(basename $0)
JENKINS_HOME_DIR=/var/lib/jenkins
BACKUP_NAME="jenkins_backup_$(date +%F_%H_%M_%S).tar.gz"
REMOTE_USER=$1
REMOTE_HOST=$2
PATH_TO_SSH_KEY=$3
PATH_TO_DOCKERFILE=$4
REMOTE_PATH=/home/${REMOTE_USER}

# Check if the script is running with two argument;
if [[ $# -ne 4 ]]
then
        echo -n "Kindly pass four args to run the script"
        echo -e "\nEx: $script_name remote_username remote_host path_to_ssh_key path_to_dockerfile\n"
        exit 1
fi

echo "Stopping jenkins...."
sudo systemctl stop jenkins

echo "Creating backup archive...."
sudo tar -czvf "${BACKUP_NAME}" "${JENKINS_HOME_DIR}" > /dev/null 2>&1

echo "Backing up to remote server ${REMOTE_HOST}"
scp -i "${SSH_KEY_PATH}" "${BACKUP_NAME}" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

echo "Transferring dockerfile to remote server ${REMOTE_HOST}"
scp -i "${SSH_KEY_PATH}" "${PATH_TO_DOCKERFILE}" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

sudo rm "${BACKUP_NAME}"

if [[ $? -eq 0 ]]
then
        echo "Backup and transfer complete"
fi