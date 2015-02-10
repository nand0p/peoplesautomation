from fabric.api import *

env.user = 'root'
env.key_filename = '~/peoples'

def deployNginx():
	run('yum -y install epel-release')
	run('yum -y install nginx')
	run('echo \'Automation for the People\' > /usr/share/nginx/html/index.html')
	run('service nginx start')
	run('chkconfig nginx on')
	run('iptables -I INPUT -p tcp --dport 80 -j ACCEPT')

