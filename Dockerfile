# Format: FROM    repository[:version]
FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Brendan Farrell <brendan_farrell@bmc.com>

# Update apt-get sources and install curl
RUN apt-get update && apt-get install -qq curl && apt-get install -qq git-core

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Update apt-get sources
RUN apt-get update && apt-get install -y mongodb-org

# Create the MongoDB data directory
RUN mkdir -p /data/db \
    mkdir -p /data/logs

# Install GO
ADD https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz /tmp/
RUN tar -xvf /tmp/go1.4.2.linux-amd64.tar.gz -C /opt
RUN ln -s /opt/go/bin/go /usr/local/bin/go 

#Start MongoDB
ENTRYPOINT ["/usr/bin/mongod"]
