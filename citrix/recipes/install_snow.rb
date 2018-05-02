directory "#{node['citrix']['snow_folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['snow_folder']}\\#{node['citrix']['snowzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['snowzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['snow_folder']}" do
  source "#{node['citrix']['snow_folder']}\\#{node['citrix']['snowzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_SnowInventoryClient' do
  guard_interpreter :powershell_script
  code "#{node['citrix']['snow_folder']}\\PKG_CTX_SnowInventoryClient_3.7.4\\SnowInventoryClient3.7.04_Citrix.EXE" 
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*SnowInventoryClient*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation SnowInventoryClient software'
    delay_mins 2
  end
