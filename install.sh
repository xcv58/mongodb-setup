#!/usr/bin/env bash

DB_PATH="/data/db"
install() {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
}

setup_path() {
    sudo mkdir -p ${DB_PATH}
    sudo chown -R mongodb:mongodb ${DB_PATH}
}

command -v mongo >/dev/null 2>&1 || install

if [ ! -d "${DB_PATH}" ]; then
    setup_path
fi


CONFIG="./configs/mongod.yaml"
CONFIG_TARGET="/etc/mongod.conf"

sudo cp -f ${CONFIG} ${CONFIG_TARGET}
# sudo service mongod restart
