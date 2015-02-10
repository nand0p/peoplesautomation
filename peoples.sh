#!/bin/bash


ACCESS_KEY=$1
SECRET_KEY=$2

AMI=ami-bc8131d4  #centos6 with updates
KEY=peoples  #aws instance root key
TYPE=t1.micro  #testing instance
AZ=us-east-1a  #virginia
export PATH=$PATH:/opt/ec2/bin
export EC2_HOME=/opt/ec2
export JAVA_HOME=/usr



instanceid=$(ec2-run-instances -O $ACCESS_KEY -W $SECRET_KEY $AMI -k $KEY -t $TYPE -z $AZ | grep INSTANCE | cut -f2)
echo "INSTANCEID: $instanceid"

sleep 5

secgroup=$(ec2-describe-instances -O $ACCESS_KEY -W $SECRET_KEY $instanceid|grep INSTANCE|cut -f28)
echo "SECGROUP: $secgroup"
newhost=$(ec2-describe-instances -O $ACCESS_KEY -W $SECRET_KEY $instanceid |grep INSTANCE | cut -f4)
echo "NEWHOST: $newhost"
ec2-authorize -O $ACCESS_KEY -W $SECRET_KEY $secgroup -P tcp -p 80 -s 0.0.0.0/0 || true

sleep 60

ssh -o StrictHostKeyChecking=no -i ~/$KEY root@$newhost "yum -y install epel-release && yum -y install nginx"
ssh -o StrictHostKeyChecking=no -i ~/$KEY root@$newhost "iptables -I INPUT -p tcp --dport 80 -j ACCEPT"
ssh -o StrictHostKeyChecking=no -i ~/$KEY root@$newhost "echo 'Automation for the People' > /usr/share/nginx/html/index.html"
ssh -o StrictHostKeyChecking=no -i ~/$KEY root@$newhost "service nginx start && chkconfig nginx on"

sleep 5


result=$(curl http://$newhost)
if [ "$result" == "Automation for the People" ]; then echo "Automation for the People is SUCCESS"; else exit 1; fi




