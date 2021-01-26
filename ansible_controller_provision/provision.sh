#!/usr/bin/env bash

# update system
sudo yum update -y

#install required packages
sudo yum install epel-release -y
sudo yum install subscription-manager -y
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo yum install ansible-2.9.16-1.el7 -y
sudo yum install git -y
sudo yum install vim -y
sudo yum install tree -y

#make ansible directory
mkdir /home/vagrant/ansible

#make ansible playbook directory
mkdir /home/vagrant/ansible/playbooks

#make ansible servers directory
mkdir /home/vagrant/ansible/playbooks/servers

#make ansible provision playbook
touch /home/vagrant/ansible/playbooks/servers/provision.yml

#configure git
mkdir /home/vagrant/git

git init /home/vagrant/git

mkdir /home/vagrant/git

git remote add origin https://github.com/schnipdip/local-ansible.git

cd /home/vagrant/git

git clone https://github.com/schnipdip/local-ansible.git

git config --global user.name "schnipdip"

git config --global user.email "cjh30@pct.edu"

git config --global user.password "E32m9zx5"



#copy files to their appropriate location(s)
sudo cp /home/vagrant/.git/git/local-ansible/sshd_config /etc/ssh/sshd_config
sudo cp /home/vagrant/.git/git/local-ansible/ansible.cfg /etc/ansible/ansible.cfg
sudo cp /home/vagrant/.git/git/local-ansible/id_rsa /root/.ssh/id_rsa
sudo cp /home/vagrant/.git/git/local-ansible/id_rsa.pub /root/.ssh/id_rsa.pub



#populate provision.yml file with data
sudo echo "
---
- hosts: localhost
  vars:
    - ../inventory

  tasks:
  - name: Answer for SSH Fingerprint Accept
    expect: 
      command: ssh-copy-id root@{{ item }}
      responses:
        Question:
          - yes
    no_log: true
    loop: "{{ query('inventory_hostnames', 'development')}}" #/etc/ansible/hosts


" >> /home/vagrant/ansible/playbooks/servers/provision.yml









