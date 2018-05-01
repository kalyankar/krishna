
remote_file "#{node['citrix']['folder']}\\#{node['citrix']['visualcppzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['visualcppzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['folder']}" do
  source "#{node['citrix']['folder']}\\#{node['citrix']['visualcppzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_vc2013_64' do
  guard_interpreter :powershell_script
  code "'#{node['citrix']['folder']}\\Visual_C++_2013_12.0.21005.1\x64\VC2013Redist.EXE' /silent "
  not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like 'Microsoft Visual C++ 2013 x64*12.0.21005'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

powershell_script 'install_vc2013_86' do
  guard_interpreter :powershell_script
  code "'#{node['citrix']['folder']}\\Visual_C++_2013_12.0.21005.1\x86\VC2013Redist.EXE' /silent "
  not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like 'Microsoft Visual C++ 2013 x86*12.0.21005'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

powershell_script 'install_vc2017_redistributable_64' do
  guard_interpreter :powershell_script
  code "#{node['citrix']['folder']}\\microsoft\\visual c++2017 redistributable\\VisualC2017Redist.EXE "
  not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like 'Microsoft Visual C++ 2017 x64 redistributable *'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

powershell_script 'install_vc2017_redistributable_32' do
  guard_interpreter :powershell_script
  code "#{node['citrix']['folder']}\\microsoft\\visual c++2017 redistributable_32Bit\\VisualC2017Redist.EXE"
  not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like 'Microsoft Visual C++ 2017 x32 redistributable *'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation of DOT NET Framework 4.7.0'
    delay_mins 2
  end
