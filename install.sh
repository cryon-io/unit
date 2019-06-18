#!/bin/sh

LATEST=$(curl -sL https://api.github.com/repos/cryon-io/unit/releases/latest | grep tag_name | sed 's/  "tag_name": "//g' | sed 's/",//g')

command -v apt-get && apt-get update && apt-get install -y -q unzip
command -v dnf && dnf -y install unzip
command -v yum && yum install -y unzip

[ ! -f "/etc/unit/unit.json" ] && printf "{
        
    }" >"/etc/unit/unit.json"

wget https://github.com/cryon-io/unit/releases/download/$LATEST/unit-linux-x64.zip -O unit.zip &&
    unzip -o unit.zip &&
    mv unit-linux-x64 /usr/sbin/unit &&
    chmod +x /usr/sbin/unit &&
    mkdir -p /etc/unit/ &&
    echo "Unit successfuly installed."
