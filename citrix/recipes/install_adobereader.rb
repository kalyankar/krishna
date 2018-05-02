directory "#{node['citrix']['adobe_folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['adobe_folder']}\\#{node['citrix']['adobezip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['adobezip']}"
  action :create
end

windows_zipfile "#{node['citrix']['adobe_folder']}" do
  source "#{node['citrix']['adobe_folder']}\\#{node['citrix']['adobezip']}"
  action :unzip
  #overwrite true
end

remote_file "#{node['citrix']['adobe_folder']}\\#{node['citrix']['adobereaderzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['adobereaderzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['adobe_folder']}" do
  source "#{node['citrix']['adobe_folder']}\\#{node['citrix']['adobereaderzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_adobe_reader' do
  guard_interpreter :powershell_script
  code "#{node['citrix']['adobe_folder']}\\Reader\\15.006.30033\\AdobeReaderDC.EXE"
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*AdobeReaderDC*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end


remote_file "#{node['citrix']['adobe_folder']}\\#{node['citrix']['AdobeReaderDCPatchzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['AdobeReaderDCPatchzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['adobe_folder']}" do
  source "#{node['citrix']['adobe_folder']}\\#{node['citrix']['AdobeReaderDCPatchzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_adobe_reader_patch1' do
  guard_interpreter :powershell_script
  code ""#{node['citrix']['adobe_folder']}\\ReaderDCPatch\\15.006.30392\\ReaderDCPatch15.006.30392.EXE" /silent "
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*ReaderDCPatch15.006.30392*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end


remote_file "#{node['citrix']['adobe_folder']}\\#{node['citrix']['AdobeReaderDCPatchzip2']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['AdobeReaderDCPatchzip2']}"
  action :create
end

windows_zipfile "#{node['citrix']['adobe_folder']}" do
  source "#{node['citrix']['adobe_folder']}\\#{node['citrix']['AdobeReaderDCPatchzip2']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_adobe_reader_patch2' do
  guard_interpreter :powershell_script
  code ""#{node['citrix']['adobe_folder']}\\ReaderDCPatch\\15.006.30413\\ReaderDCPatch15.006.30413.EXE" /quiet "
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*ReaderDCPatch15.006.30413.EXE*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end


  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation Adobe Reader software'
    delay_mins 2
  end
