# Ambilight Server Automation

Modified: 2022-01

Ansible automation for setup and teardown of hyperion servers for raspbian lite.

## Quickstart

Install ansible
```bash
python3 -m pip install ansible
```

Run the prelink directive passing the hostname and ip address of the pi. On rasbian the default hostname is `pi`.
```bash
./scripts/prelink.sh -u $HOSTNAME -a $IP_ADDRESS
```

Run the automation
```bash
ansible-playbook main.yaml
```

Teardown
```bash
ansible-playbook main.yaml
```