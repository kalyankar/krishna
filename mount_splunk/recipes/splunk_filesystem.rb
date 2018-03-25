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

