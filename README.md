# Hyperion Server Automation

[![ci](https://github.com/ztnel/ambilight/actions/workflows/ci.yaml/badge.svg)](https://github.com/ztnel/ambilight/actions/workflows/ci.yaml)

Modified: 2022-01

Ansible automation for setup and teardown of hyperion servers for raspbian lite.

## Quickstart

Install ansible
```bash
python3 -m pip install ansible
```

Run the prelink directive passing the hostname and ip address of the pi. On rasbian the default hostname is `pi`. For example:
```bash
./scripts/prelink.sh -u pi -a 192.168.2.19
```
This essentially just adds your host systems public key to the list of authorized keys on the pi which is required to run ansible. 

>By default the script will look in `~/.ssh` for an `id_rsa.pub` file but you can pass a custom ssh keypath with the -p flag:
>```bash
>./scripts/prelink.sh -u $HOSTNAME -a $IP_ADDRESS -p $SSH_KEYPATH
>```

Run deployment automation
```bash
ansible-playbook main.yml -e '{ teardown: False }' -K
```

Teardown
```bash
ansible-playbook main.yml -e '{ teardown: True }' -K
```