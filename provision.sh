#!/bin/bash
set -e

# install analyze-local-images
yum install -y golang
export GOPATH=/tmp/analyze
export PATH=$PATH:/tmp/analyze/bin
go get -u github.com/coreos/clair/contrib/analyze-local-images

# run clair
curl -L https://raw.githubusercontent.com/coreos/clair/v1.2.4/docker-compose.yml -o $HOME/docker-compose.yml
mkdir $HOME/clair_config
curl -L https://raw.githubusercontent.com/coreos/clair/v1.2.4/config.example.yaml -o $HOME/clair_config/config.yaml
$EDITOR $HOME/clair_config/config.yaml # Edit database source to be postgresql://postgres:password@postgres:5432?sslmode=disable
docker-compose -f $HOME/docker-compose.yml up -d

# scan docker image
#analyze-local-images postgres

