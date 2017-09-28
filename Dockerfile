# Docker-in-Docker Jenkins Slave
#
#
FROM sot001/ansible-slave:latest

# remove old docker versions and install new
# from https://docs.docker.com/engine/installation/linux/ubuntu/#install-docker
#

# swap back to root as jnlp-slave leaves us as jenkins
USER root

RUN apt-get update

# add requirements
RUN apt-get -y install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common

# get the gpg key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# add docker repo
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
      $(lsb_release -cs) \
         stable"

RUN apt-get update
RUN apt-get -y install docker-ce

# add jenkins to docker group
RUN usermod -a -G docker jenkins

# now we can swap back to jenkins
USER jenkins

