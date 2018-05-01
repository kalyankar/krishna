directory "#{node['citrix']['ms_folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['ms_folder']}\\#{node['citrix']['dotnetzip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['dotnetzip']}"
  action :create
end

windows_zipfile "#{node['citrix']['ms_folder']}" do
  source "#{node['citrix']['ms_folder']}\\#{node['citrix']['dotnetzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_dotnet' do
  guard_interpreter :powershell_script
  code "#{node['citrix']['ms_folder']}\\DotNETFramework\\4.7.0.2053\\DotNetFramework.EXE"
  not_if "Get-ChildItem 'HKLM:\\SOFTWARE\\Microsoft\\NET Framework Setup\\NDP' -Recurse | Get-ItemProperty -name version -EA 0  | Where { $_.PSChildName -match '^(?!S)\p{L}'} | Select Version | Where {$_.Version -match '4.7.0'}"
  notifies :reboot_now, 'reboot[reboot_server]', :immediately
end

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation of DOT NET Framework 4.7.0'
    delay_mins 2
  end
