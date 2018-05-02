directory "#{node['citrix']['folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['folder']}\\#{node['citrix']['pdfzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['pdfzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['folder']}" do
  source "#{node['citrix']['folder']}\\#{node['citrix']['pdfzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_pdfwriter' do
  guard_interpreter :powershell_script
  code ""#{node['citrix']['folder']}\\Custom PDF Writer\\Setup.exe" -s -d"C:\\Program Files (x86)\\UHC PDF Writer""
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*Custom PDF Writer*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation Custom PDF Writer software'
    delay_mins 2
  end
