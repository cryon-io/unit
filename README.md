## Unit - Entry point to your node world

Multi crypto node setup, management and monitoring.

## Prerequisites 

1. 64-bit installation
2. 3.10 or higher version of the Linux kernel (latest is recommended)

(If you run on VPS provider, which uses OpenVZ, setup requires at OpenVZ 7)

## Setup nodes with unit 

**Run bellow commands as root.**

1. install unzip
    - Ubuntu: `apt install unzip -y`
2. download and unzip unit binary:
```sh
    LATEST=$(curl -sL https://api.github.com/repos/cryon-io/unit/releases/latest | grep tag_name | sed 's/  "tag_name": "//g' | sed 's/",//g')
    wget https://github.com/cryon-io/unit/releases/download/$LATEST/unit-linux-x64.zip -O unit.zip && \
    unzip -o unit.zip && \
    mv unit-linux-x64 /usr/bin/unit && \
    chmod +x /usr/bin/unit
```
    - (optional) `unit help`        # check help 
3. Prepare **/etc/unit/unit.json** configuration file
    - `mkdir -p /etc/unit/ && nano /etc/unit/unit.json`
    - for examples check out [templates](https://github.com/cryon-io/unit/tree/master/templates) in this repository.
4. `unit setup`  # setups all nodes defined in unit.json
5. `unit start`       # starts all nodes defined in unit.json
6. `unit info`        # prints details about nodes and VPS

### unit.json

It is *unit* configuration file. Unit looks up for unit.json in following paths and in order:
1. directory the *unit* is located in
2. current working directory
3. `/etc/unit/unit.json` 

### Swap

You can specify swap space size in GB required for template, e.g. configuration for 2GB swap space:
```json
    ...
    "swap" : 2  
    ...
```
Defaults to 0.

*Swap is created/adjusted automatically when executed `setup` command or manually by `configure-swap` command.*

### Updates

- `unit update`                               # updates binary to latest 
- `unit auto-update [status|apply]`  # shows status/applies auto update based on unit.json 

You can specify `"auto_update":true` in unit.json to enable auto updates on setup

### Global options (unit.json)

These options are all passed to all nodes, but do not override node specific options. 

#### unit.json options

- `"logLevel" : [string from below]`    # level of unit log output (default is info)
  - `"trace"`
  - `"debug"`
  - `"info"`
  - `"warn"`
  - `"error"`
- `"path": [fully qualified path]`      # path where are nodes saved unless overridden by node options
- `"global": { [options from below] }`  # options available for all nodes
  - `"environment": [ "env1=val1" ]`    # array of environment variables passed to all nodes, separated by comma
                                        # for list of supported env variables check out specific node docs
  - `"parameters": [ "par1=val1" ]`     # array of parameters passed to all nodes, separated by comma
                                        # for list of supported params check out specific node docs
  - `"auto_updates" : "all"`            # auto update option passed to all nodes as default value
    - `off`       # no auto updates
    - `node`      # auto update node binaries
    - `service`   # auto update node binaries and node container definition
    - `all`       # above + ans auto updates

- `"nodes" : [ { ... }, {...} ]`        # array of nodes 

### unit.json node specific options

- `"id": "node1"`                           # **required** unique node id
- `"type": "node_type"`                     # **required** Node type from list of [supported nodes](https://github.com/cryon-io/ans/wiki/Supported-Node-Types)
- `"path": "fully qualified path"`          # path where where to store node
- `"environment": [...]`                    # similar to global "environment" but node specific
- `"parameters": [...]`                     # similar to global "parameters" but node specific
- `"auto_updates": "all"`                   # similar to global "auto_updates" but node specific
- `"user": "user1"`                         # user under which to setup node
- `"binds": [ "192.168.52.28:5001:5000" ]`  # list of binds separated by comma
                                            # binds specified node ports to host ports
                                            # above example binds port 5000 of node to 192.168.52.28:5001
- `"ans-branch": "master"`                  # uses specific branch of ans repository (*defaults master*)
- `"node-branch": "master"`                 # uses specific branch of node repository (*defaults master*)

### Pruning nodes

If you want to rerun from clean setup you can run prune command:
- `unit prune`                # removes service definitions and data for all nodes from unit.json
- `unit prune [node id]`      # removes service definitions and data for selected node/s from unit.json
- `unit prune-data`           # removes data for all nodes rom unit.json
- `unit prune-data [node id]` # removes data for selected node/s from unit.json

### Reset node

In case your node got into invalid state (e.g. blockchain corruption caused by power loss), you can reset it with:
- `unit reset-node`                       # resets all nodes from unit.json = 'stop' + 'prune-data' + 'setup' + 'start'
- `unit reset-node [nodeId], [nodeId]`    # resets selected nodes from unit.json = 'stop' + 'prune-data' + 'setup' + 'start'
