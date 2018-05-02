directory "#{node['citrix']['folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['folder']}\\#{node['citrix']['swpzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['swpzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['folder']}" do
  source "#{node['citrix']['folder']}\\#{node['citrix']['swpzip']}"
  action :unzip
  #overwrite true
end

remote_file "#{node['citrix']['folder']}\\Install PKG-CTX-IE11_2012.zip" do
  source "#{node['citrix']['share']}\\Install PKG-CTX-IE11_2012.zip"
  action :create
end

windows_zipfile "#{node['citrix']['folder']}" do
  source "#{node['citrix']['folder']}\\Install PKG-CTX-IE11_2012.zip"
  action :unzip
  #overwrite true
end

powershell_script 'install_auth' do
  guard_interpreter :powershell_script
  code "#{node['citrix']['folder']}\\IE11_2012\IE11Install_S2012R2.EXE"
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*IE11*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation IE11 software'
    delay_mins 2
  end
