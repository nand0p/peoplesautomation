#!/bin/bash

thishost=$(knife ec2 server create --groups=default --region=us-east-1 --availability-zone=us-east-1a --image=ami-895069fd --flavor=t1.micro --ssh-user=root --ssh-key=peoples --identity-file=~/peoples)

ssh -i peoples root@$thishost "puppet agent -t -server puppetmaster.fqdn"
