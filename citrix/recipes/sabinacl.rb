directory "#{node['citrix']['subinacl_folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['subinacl_folder']}\\#{node['citrix']['subinaclzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['subinaclzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['subinacl_folder']}" do
  source "#{node['citrix']['subinacl_folder']}\\#{node['citrix']['subinaclzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_subinacl' do
  guard_interpreter :powershell_script
  code "MSIEXEC /I "#{node['citrix']['subinacl_folder']}\\subinacl.msi" /QN "
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*subinacl*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation subinacl software'
    delay_mins 2
  end
