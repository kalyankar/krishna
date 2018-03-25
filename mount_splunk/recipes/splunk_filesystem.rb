group node['mount_splunk']['group'] do
  action :create
end

user node['mount_splunk']['user'] do
  gid node['mount_splunk']['group']
  shell '/bin/bash'
  home "/home/#{node['mount_splunk']['user']}"
  supports manage_home: true
  system true
  action :create
end

directory node['mount_splunk']['mount_point'] do
  owner node['mount_splunk']['user']
  group node['mount_splunk']['group']
  mode '0755'
  action :create
end

# create a filesystem
execute 'mkfs' do
  command "mkfs -t #{node['mount_splunk']['filesystem']} #{node['mount_splunk']['device_id']}"
  # only if it's not mounted already
  not_if "grep -qs #{node['mount_splunk']['mount_point']} /proc/mounts"
end

# resize file system
#execute 'resize' do
#  command "resize2fs #{node['mount_splunk']['device_id']} #{node['mount_splunk']['size']}"
  # only if the device exists
#  only_if "if [ -e #{node['mount_splunk']['device_id']} ]; then echo 'True' ; fi"
#end

mount "#{node['mount_splunk']['mount_point']}" do
  fstype   node['mount_splunk']['filesystem']
  device   node['mount_splunk']['device_id']
  options  'mode=#{node['mount_splunk']['permission']},size=#{node['mount_splunk']['size']}'
  action   [:mount, :enable]
end
