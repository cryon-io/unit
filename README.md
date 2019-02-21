## Unit - Entrypoint to your node world

Multi crypto node setup, management and monitoring.

## Prerequisites 

1. 64-bit installation
2. 3.10 or higher version of the Linux kernel (latest is recommended)

(If you run on VPS provider, which uses OpenVZ, setup requires at OpenVZ 7)

## Setup nodes with unit 

0. `./unit help`        # check help 
1. create unit.json file
2. `sudo ./unit setup`  # setups all nodes defined in unit.json
3. `./unit start`       # starts all nodes defined in unit.json
4. `./unit info`        # prints details about nodes

For examples of unit.json check out templates in this repository.

### Updates

- `./unit update`                               # updates binary to latest 
- `./unit auto-update [enable|status|disable]`  # enables/shows status/disables auto update of unit 

You can specify `"auto_update":true` in unit.json to enable auto updates on setup

### Global options (util.json)

These options are all passed to all nodes, but do not override node specific options. 

#### unit.json options

- `"logLevel" : [number from below]`    # level of unit log output
  - 0 # trace
  - 1 # debug
  - 2 # info
  - 3 # warn
  - 4 # error
  - 5 # fatal
- `"path": [fully qualified path]`      # path where are nodes saved unless overriden by node options
- `"global": { [options from below] }`  # options avalable for all nodes
  - `"environment": [ "env1=val1" ]`    # array of environment variables passed to all nodes, separated by comma
                                        # for list of supported env variables check out specific node docs
  - `"parameters": [ "par1=val1" ]`     # array of parameters passed to all nodes, separated by comma
                                        # for list of supported params check out specific node docs
  - `"auto_updates" : "all"`            # auto update option passed to all nodes as default value
    - `off`       # no auto updates
    - `node`      # auto update node binaries
    - `service`   # auto update node container definition
    - `all`       # above + ans auto updates

- `"nodes" : [ { ... }, {...} ]`        # array of nodes 

#### unit.json node specific options

- `"id": "node1"`                           # **required** unique node identificator
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