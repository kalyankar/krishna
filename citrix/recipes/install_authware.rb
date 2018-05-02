
directory "#{node['citrix']['auth_folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['auth_folder']}\\#{node['citrix']['authzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['authzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['auth_folder']}" do
  source "#{node['citrix']['auth_folder']}\\#{node['citrix']['authzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_auth' do
  guard_interpreter :powershell_script
  code "MSIEXEC /I "#{node['citrix']['auth_folder']}\\MacromediaAuthorware7.msi" TRANSFORMS=AuthorwareCitrix7.0.mst INSTALLDIR="C:\Program Files (x86)\MacromediaAuthorware 7"
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*Authorware*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation MacromediaAuthorware7 software'
    delay_mins 2
  end
