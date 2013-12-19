role-balanced-proxy
===================

Role for proxy-ing balanced api request.

Setup
=====

Setup your environment like:

```bash
$ cd ~/code/bp/chef
$ echo $CONFUCIUS_ROOT
/code/bp/chef/confucius
$ cd cookbooks
$ git clone git@github.com:balanced-cookbooks/role-balanced-proxy.git
...
$ cd role-balanced-proxy
```

Testing
=======

```
$ vagrant up --provision
...
$ vagrant ssh
``` 

Provision
=========

Use these:

- ami *ami-aa4070ef* (ephemeral), *ami-???* (ebs)
- security group *sg-811f08e3*
- subnets (live)  **, **
- subnets (non-live) *subnet-abd9d2c9*, *subnet-5d3c681b*

```bash
$ knife ec2 server create \
--image ami-aa4070ef \
--flavor m1.medium \
--security-group-ids sg-811f08e3 \
--availability-zone us-west-1a \
--subnet subnet-5d3c681b \
--region us-west-1 \
--iam-profile balanced-proxy \
--run-list "role[balanced-proxy]" \
--ssh-user ubuntu \
--server-connect-attribute private_ip_address \
--ssh-port 22 \
--ssh-gateway andrew@50.18.199.26 \
--identity-file ~/.ssh/aws-pp-ai-gazelle.pem \
--environment dev
```
