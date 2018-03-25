# Following are the attributes for mounting splunk.
default['mount_splunk']['mount_point'] = '/opt/splunk'
default['mount_splunk']['device_id'] = '/dev/sda1'
default['mount_splunk']['filesystem'] = 'ext4'
default['mount_splunk']['size'] = '10G'
default['mount_splunk']['user'] = 'splunk'
default['mount_splunk']['group'] = 'splunk'
default['mount_splunk']['permission'] = '0775'    
