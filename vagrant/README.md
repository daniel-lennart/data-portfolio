# Vagrant VM provisioning example
## Description
This configuration example will do the following:

* Create a centos 7 Vagrant virtual machine
* Create admin user
* Add SSH key for the user
* Install Ansible, EPEL repo, development tools
* Install default toolset defined in configuration file
* Run Ansible playbooks to
 * Install Docker
 * Create and start Jenkins docker container
* Backup docker data volumes on halting the VM

## Usage
```
vagrant up
```
in vm directory to start the VM

---
```
vagrant provision
```
in vm directory to reprovision existing VM after changing settings

---
```
vagrant halt
```
in vm directory to backup data volumes and stop the VM

---
```
vagrant destroy
```
in vm directory to destroy VM and data

---

User, SSH key and toolset configuration is defined in [CFG.yml](provisioning/CFG.yml)
