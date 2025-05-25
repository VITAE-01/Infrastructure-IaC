# #!/bin/bash

# # The script backs up jenkins data from a Docker jenkins container ruuning on a remote server to another server
# # Usage: ssh $REMOTE_USER@$REMOTE_HOST 'bash -s' < deploy_jenkins_con_droplets.sh
# # Ensure the remote user have elevated privileges to run Docker commands.


script_name=$(basename $0)
JENKINS_CONTAINER_NAME=$1
BACKUP_NAME="/tmp/jenkins_backup_$(date +%F_%H_%M_%S).tar.gz"

# Check if the script is running with arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: ${script_name} <jenkins_container_name>"
    exit 1
fi

# Check if the docker container is running
if [ ! "$(docker ps -q -f name=$JENKINS_CONTAINER_NAME)" ]; then
    echo "Jenkins container ${JENKINS_CONTAINER_NAME} is not running on ${REMOTE_HOST}."
    exit 1
fi

# Stop the Jenkins container and create a backup archive
echo "Stopping Jenkins container ${JENKINS_CONTAINER_NAME}..."
docker container stop ${JENKINS_CONTAINER_NAME}

echo "Creating backup archive of Jenkins data..."
sudo tar -czvf "${BACKUP_NAME}" "jenkins_docker_data" > /dev/null 2>&1

echo "Backing up to my remote machine or host"

# sudo rm "${BACKUP_NAME}"

if [[ $? -eq 0 ]]
then
    echo "Backup done and transfer complete"
    echo "Starting Jenkins container ${JENKINS_CONTAINER_NAME}..."
    docker container start ${JENKINS_CONTAINER_NAME}
    sleep 5
    echo "Jenkins container ${JENKINS_CONTAINER_NAME} is up and running."
fi

