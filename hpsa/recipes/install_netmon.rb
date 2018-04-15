remote_file "#{node['hpsa']['localpath']}\\#{node['hpsa']['netmonzip']}" do
  source "#{node['hpsa']['share']}\\#{node['hpsa']['netmonzip']}"
  action :create
end

windows_zipfile "#{node['hpsa']['localpath']}\\#{node['hpsa']['netmon']}" do
  source "#{node['hpsa']['localpath']}\\#{node['hpsa']['netmonzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_netmon' do
  guard_interpreter :powershell_script
  code "msiexec /quiet /i #{node['hpsa']['localpath']}\\#{node['hpsa']['netmon']}\\netmon.msi"
  #not_if ""
end
