remote_file "#{node['hpsa']['localpath']}\\#{node['hpsa']['hpsumzip']}" do
  source "#{node['hpsa']['share']}\\#{node['hpsa']['hpsumzip']}"
  action :create
end

windows_zipfile "#{node['hpsa']['localpath']}\\#{node['hpsa']['hpsum']}" do
  source "#{node['hpsa']['localpath']}\\#{node['hpsa']['hpsumzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_hpsum' do
  guard_interpreter :powershell_script
  code "#{node['hpsa']['localpath']}\\#{node['hpsa']['hpsum']}\\hp\\swpackages\\hpsum.bat /force:all /allow_non_bundle_components /use_snmp /silent /tpmbypass set errorlevel  =0"
  #not_if ""
end
