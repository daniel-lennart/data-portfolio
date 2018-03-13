

# Various [Ansible](https://www.ansible.com/) configuration management commands

Show groups

`ansible -m debug -i inventories/inventory.sh -a "var=hostvars[inventory_hostname]['group_names']" [inventory hostname]`

Show hosts in group

`ansible -i inventories/inventory.sh -m ping [ group name ] --list-hosts`

Run playbook

`ansible-playbook -i inventories/inventory.sh -l [ group name ] [ playbook name ]`

Run command against all servers

`ansible -i inventories/inventory.sh '*' -m shell -a 'grep "https://mgmt" /etc/yum.repos.d/remi*'`

Run release against 1 server

`ansible-playbook -i inventories/inventory.sh -l [ server name ] [release playbook]`

Run for specific host from specific task

`ansible-playbook [release playbook] -i inventories/inventory.sh -l '[server-hostname]' -D --start-at-task 'Install cloudfuse'`

Run mysql query

`ansible -i inventories/inventory.sh -m shell -a 'sudo mysql --execute="SELECT user,host FROM mysql.user"' [db-servers-group-name]`

find what servers use SSL certificate

`ansible -i inventories/inventory.sh '*' -m shell -a 'find /etc/httpd/conf/certificates -name "ssl.crt"'`

Run tag against server

`ansible-playbook [release playbook] -i inventories/inventory.sh -l '[server.hostname]' -D --check --tags "[tag_name]"`


Run site play against staging environment
`ansible-playbook -i inventories/inventory.sh -u centos -l group_staging [release playbook] --list-hosts`

Run user management playbooks from main release playbook
`ansible-playbook -i inventories/inventory.sh -u centos -l max-main-stg02 --tags "user_management" [release playbook]`

Limit playbook to  several groups and list hosts:
`ansible-playbook -i inventories/inventory.sh -u centos -l group1:group2 [release playbook] --list-hosts`

Gather and cache facts to use with other group
`ansible -i inventories/inventory.sh 'group name' -m setup`

Run specific task
`ansible-playbook [task playbook] -i inventories/inventory.sh -e "task_playbook=some_task.yml"`
