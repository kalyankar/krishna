directory "#{node['citrix']['citrix_folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['citrix_folder']}\\#{node['citrix']['citrixzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['citrixzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['citrix_folder']}" do
  source "#{node['citrix']['citrix_folder']}\\#{node['citrix']['citrixzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_Citrix Receiver' do
  guard_interpreter :powershell_script
  code "#{node['citrix']['citrix_folder']}\\Citrix Receiver 14.9.1000.17 Package\\CitrixReceiver.EXE"
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*Citrix Receiver*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation Citrix Receiver software'
    delay_mins 2
  end
