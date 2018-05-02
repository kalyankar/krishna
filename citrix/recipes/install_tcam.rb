directory "#{node['citrix']['folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['folder']}\\#{node['citrix']['tcamzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['tcamzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['folder']}" do
  source "#{node['citrix']['auth_folder']}\\#{node['citrix']['tcamzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_TCAM' do
  guard_interpreter :powershell_script
  code "MSIEXEC /I "#{node['citrix']['folder']}\\TCAM-12.2.3.1-x64\TCAM_x64.msi" /qn /L "C:\\Citrix\\Installs\\TCAM-12.2.3.1- x64\\TCAM_12.2.3.1_Install_LogFile.txt" "
  #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*TCAM*'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

batch 'config_TCAM' do
  code <<-EOH

Xcopy "C:\\Program Files\\Compuware\\TCAM\\vtcams.exe"
vtcams -amd clear 
vtcams -resolvenat on 
vtcams -amd perf 10.177.72.79:6666 
vtcams -amd add 10.214.5.58:6666 
vtcams -amd add 10.216.32.39:6666 
vtcams -amd add 10.123.232.159:6666 
vtcams -amd add 10.123.232.53:6666 
vtcams -amd add 10.123.232.89:6666 
vtcams -amd add 10.179.104.93:6666 
vtcams -amd add 10.179.104.90:6666 
vtcams -amd add 10.179.104.91:6666 
vtcams -amd add 10.179.104.92:6666 
vtcams -amd add 10.204.132.40:6666 
vtcams -amd add 10.204.132.41:6666 
vtcams -amd add 10.204.132.42:6666 
vtcams -amd add 10.204.132.43:6666 
vtcams -amd add 10.178.76.52:6666 
vtcams -amd add 10.177.10.179:6666 
vtcams -amd add 10.114.34.80:6666 
vtcams -amd add 10.178.72.235:6666 
vtcams -amd add 10.177.10.182:6666 
vtcams -amd add 10.177.8.52:6666
vtcams -amd add 10.114.162.52:6666 
vtcams -amd add 10.179.40.156:6666 
vtcams -amd add 10.179.40.153:6666 
vtcams -amd add 10.179.40.154:6666 
vtcams -amd add 10.179.40.155:6666 
vtcams -amd add 10.114.232.60:6666 
vtcams -amd add 10.123.232.88:6666 
vtcams -amd add 10.178.72.115:6666 
vtcams -amd add 10.179.72.234:6666 
vtcams -amd add 10.114.112.30:6666 
vtcams -amd add 10.106.20.44:6666 
vtcams -amd add 10.106.20.45:6666 
vtcams -amd add 10.177.8.92:6666 
vtcams -amd add 10.122.40.73:6666 
vtcams -amd add 10.114.232.52:6666 
vtcams -amd add 10.177.72.31:6666   
vtcams -amd add 10.177.72.36:6666   
vtcams -amd add 10.177.72.48:6666   
vtcams -amd add 10.177.72.49:6666   
vtcams -amd add 10.177.72.50:6666   
vtcams -amd add 10.177.72.55:6666   
vtcams -amd add 10.177.72.56:6666   
vtcams -amd add 10.177.72.57:6666   
vtcams -amd add 10.177.72.58:6666   
vtcams -amd add 10.177.72.59:6666   
vtcams -amd add 10.177.72.63:6666   
vtcams -amd add 10.177.72.68:6666   
vtcams -amd add 10.177.72.69:6666   
vtcams -amd add 10.177.72.71:6666   
vtcams -amd add 10.177.72.73:6666   
vtcams -amd add 10.177.72.74:6666   
vtcams -amd add 10.177.72.84:6666   
vtcams -amd add 10.122.200.189:6666 
vtcams -amd add 10.122.200.231:6666 
vtcams -amd add 10.122.200.239:6666 
vtcams -amd add 10.122.200.247:6666 
vtcams -amd add 10.122.201.8:6666   
vtcams -amd add 10.122.201.27:6666  
vtcams -amd add 10.122.201.36:6666  
vtcams -amd add 10.122.201.42:6666  
vtcams -amd add 10.122.201.46:6666  
vtcams -amd add 10.177.72.77:6666 
vtcams -amd add 10.177.72.75:6666 
vtcams -amd add 10.177.72.60:6666 
vtcams -amd add 10.179.188.69:6666 
vtcams -amd add 10.177.72.112:6666 
vtcams -amd add 10.165.42.26:6666 
vtcams -amd add 10.155.66.237:6666 
vtcams -amd add 10.155.66.238:6666 
vtcams -amd add 10.139.163.190:6666 
vtcams -amd add 10.178.72.35:6666 
vtcams -amd add  
vtcams -restart 
    EOH
 notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation TCAM software'
    delay_mins 2
  end
