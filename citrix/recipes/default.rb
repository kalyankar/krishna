directory "#{node['citrix']['folder']}" do
  recursive true
  action :create
end
