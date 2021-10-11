# README

## Part A

## Question 1 - Using Docker and Bash

Using bash script, Write a script that will automatically provision 3 docker
containers running kibana version 6.4.2, nginx server, mysql server separately on
each container.

**Environment**: Docker CE, Ubuntu 18

Write a script, which will be:
container A: kibana version 6.4.2
container B: nginx server
container C: mysql server

**Acceptance criteria**: Solution should be prepared as only one script, which
creates three Docker images, run containers from them, configures Nginx.
The three docker containers should be able to ping each other regardless of where
they are being deployed. Provide a well documented steps for how to reproduce your work.

## Solution 1

First, ensure that you have the Ubuntu server/virtual machine setup.

Next, setup Docker and other docker dependencies on the server by following the
steps in the links below:

[Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
[Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)

You can confirm that docker is all setup by running the commands below:

    docker version        # display docker version
    docker container ls   # list all containers

Next, run the `docker_containers.sh` script to create a docker network,
create mysql data directory, pull the kibana, nginx and mysql docker images and
start up corresponding containers for them using the command below:

    sh docker_containers.sh

This should create a docker network, create mysql data directory, pull
the kibana, nginx and mysql docker images and start up their corresponding
containers. To confirm that everything is fine, run the command below:

    docker container ls

Next, we need to test the ping connectivity among the containers. To achieve we
do the below in all the running containers. First, we will access the containers
using the command:

    docker container exec -it CONTAINER_ID bin/bash

**Note**: You can get the individidual CONTAINER_IDs by running the command -
`docker container ls`.

Next, the following commands to install the ping package on each container:

    apt update
    apt install iputils-ping
    exit

Finally, run the following commands to test the ping connectivity among the containers:

    docker exec -it nginx ping kibana
    docker exec -it nginx ping mysql
    docker exec -it mysql ping kibana
    docker exec -it mysql ping nginx
    docker exec -it kibana ping nginx
    docker exec -it kibana ping mysql

To clean up everything run the commands below:

    docker rm -f nginx || true
    docker rm -f mysql || true
    docker rm -f kibana || true
    docker network rm arcapayments
    docker system prune -a

### Question 2 - Terraform with Python for Infrastructure Automation

Write a CloudFormation Template to provision a server in a default VPC
write a python script to start the provisioned server
write a python script to stop the provisioned server

### Solution 2

To get the solutions below to run from your local machine be sure to install
the **AWS CLI** on your local machine and authenticate with it using your credentials.

The CloudFormation script to provision a server on a default VPC can be found
in the `cloudformation_server.yml` file. You can also find the terraform
equivalence in the `terraform_server.yml` file. The terraform script can be
structured better into modules but time was a constraint.

The python script to start and stop the provisioned server can be found in the
`python_start.py` and `python_stop.py` files respectively. To run them you need
to first install boto3 and other dependencies following th steps here -
[Boto3 quickstart](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html).

The scripts can be run thus using `python3`:

    /usr/bin/python3 python_start_server.py       # start provisioned server

    /usr/bin/python3 python_sop_server.py stop    # stop provisioned server

**Note**: Ensure to replace the `id` variable with the corresponding instance id
of the server instance that you want to start or stop.
