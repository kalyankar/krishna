remote_file "#{node['hpsa']['localpath']}\\#{node['hpsa']['tbmrzip']}" do
  source "#{node['hpsa']['share']}\\#{node['hpsa']['tbmrzip']}"
  action :create
end

windows_zipfile "#{node['hpsa']['localpath']}\\#{node['hpsa']['tbmr']}" do
  source "#{node['hpsa']['localpath']}\\#{node['hpsa']['tbmrzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_tbmr' do
  guard_interpreter :powershell_script
  code <<-EOH
"@echo off 
Find /i \"BKUPTYPE: 1\" < #{node['hpsa']['localpath']}\\Servers\\execute\\ca.cfg > #{node['hpsa']['localpath']}\\#{node['hpsa']['tbmr']}\\TSMCheck.txt If %ERRORLEVEL% == 0 ( call #{node['hpsa']['localpath']}\\#{node['hpsa']['tbmr']}\\install_tbmr.bat ) ELSE (     Echo \"TSM is not used on this server.  Tivoli Bare Metal Recovery will not be installed\" ) 
EOH"
  #not_if ""
end
