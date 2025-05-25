# This script remotely builds a Docker image for Jenkins and runs it in a container.
# It also sets up the necessary volume mounts configurations.
# Usage: ssh $REMOTE_USER@$REMOTE_HOST 'bash -s' < deploy_jenkins_con_droplets.sh
# Ensure the remote user have elevated privileges to run Docker commands.

#!/bin/bash
script_name=$(basename $0)
REMOTE_USER=$1
JENKINS_CONTAINER_NAME=$2
BACKUP_ARCHIVE=$(ls /home/${REMOTE_USER}/jenkins_backup_*.tar.gz 2>/dev/null | head -n 1)
JENKINS_DOCKER_DATA_DIR="/home/${REMOTE_USER}/jenkins_docker_data"

# Check if the script is running with two arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: ${script_name} <remote_user> <jenkins_container_name>"
    exit 1
fi

# Build the Docker image for Jenkins
docker build -f ./Dockerfile.jenkins -t jenkins-docker .

# Create the Jenkins container
docker container create -u root \
    --name ${JENKINS_CONTAINER_NAME} \
    -e JENKINS_HOME=/var/lib/jenkins \
    -p 8080:8080 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${JENKINS_DOCKER_DATA_DIR}:/var/lib/jenkins \
    jenkins-docker

# Start the Jenkins container
docker container start ${JENKINS_CONTAINER_NAME}

# Wait until the container is running before executing commands inside it
until [ "$(docker inspect -f '{{.State.Running}}' ${JENKINS_CONTAINER_NAME} 2>/dev/null)" == "true" ]; do
    sleep 2
done

# Remove any existing jenkins configuration files from the container
docker exec -u root ${JENKINS_CONTAINER_NAME} rm -rf /var/lib/jenkins/*

# Restore Jenkins configuration from backup if available
if [ -f "$BACKUP_ARCHIVE" ]; then
    echo "Restoring Jenkins configuration from backup: $BACKUP_ARCHIVE"
    docker cp "$BACKUP_ARCHIVE" "${JENKINS_CONTAINER_NAME}:/var/lib/jenkins_backup.tar.gz"
    docker exec -u root ${JENKINS_CONTAINER_NAME} tar -xzf /var/lib/jenkins_backup.tar.gz -C /var/lib/jenkins --strip-components=3
    docker exec -u root ${JENKINS_CONTAINER_NAME} rm /var/lib/jenkins_backup.tar.gz
else
    echo "No backup archive found. Skipping restoration."
fi

# Restart the Jenkins container to apply changes
docker container restart ${JENKINS_CONTAINER_NAME}
# Wait for Jenkins to start
echo "Waiting for Jenkins to restart..."
sleep 30

# Check if Jenkins is running
if [ "$(docker ps -q -f name=$JENKINS_CONTAINER_NAME)" ]; then
    echo "Jenkins successfully restored from backup and running."
    # Remove the backup archive
    rm -f "$BACKUP_ARCHIVE"
else
    echo "Jenkins failed to start."
    exit 1
fi