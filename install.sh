#!/bin/sh

LATEST=$(curl -sL https://api.github.com/repos/cryon-io/unit/releases/latest | grep tag_name | sed 's/  "tag_name": "//g' | sed 's/",//g')
wget https://github.com/cryon-io/unit/releases/download/$LATEST/unit-linux-x64.zip -O unit.zip &&
    unzip -o unit.zip &&
    mv unit-linux-x64 /usr/bin/unit &&
    chmod +x /usr/bin/unit &&
    mkdir -p /etc/unit/ &&
    [ ! -f "/etc/unit/unit.json" ] && printf "{
        
    }" >"/etc/unit/unit.json" &&
    echo "Unit successfuly installed."
