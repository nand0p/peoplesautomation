<h1>Automation for the People</h1>


```
bash script "./peoples.sh [access_key] [secret_key]"
 - requires ec2 apitools 1.7.3.0 2014-10-01
```

```
jenkins conf "jenkins.xml" 
 - requires envinject@1.90
 - access_key and secret_key in job parameters
```

```
python script "./peoples.py [access_key] [secret_key]"
 - boto and fabric (fabfile import)
```

```
puppet class "peoples::automation"
 - allinclusive to bootstrap microapp 
 - puppetmaster requires jfryman-nginx module
```

```
chef recipe "peoples.rb"
```

```
knife with puppet "peoples.knife.sh"
```
