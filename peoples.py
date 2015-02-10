#!/usr/bin/python


import boto.ec2
import time
import subprocess
from fabfile import deployNginx
from fabric.context_managers import settings

aws_access_key_id='AKIAJVKYWXZADWBFXYTQ'
aws_secret_access_key='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'

conn = boto.ec2.connect_to_region("us-east-1", 
	aws_access_key_id=aws_access_key_id,
	aws_secret_access_key=aws_secret_access_key)

r = conn.run_instances('ami-bc8131d4', instance_type='t1.micro', key_name='peoples')

instance = r.instances[0]
status = instance.update()

while status == 'pending':
    time.sleep(10)
    status = instance.update()
    print status

if status == "running":
    time.sleep(5)
    print('Instance status: ' + status)
    thishost = instance.public_dns_name
    print thishost

print("waiting for instance...")
time.sleep(30)
with settings(host_string='%s' % thishost):
    deployNginx()