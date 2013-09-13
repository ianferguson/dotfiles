#!/bin/bash

set -e

mkdir -p ~/vagrant/
cd ~/vagrant
git clone https://github.com/dotcloud/docker.git
cd docker
vagrant up
