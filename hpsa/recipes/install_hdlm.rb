remote_file "#{node['hpsa']['localpath']}\\#{node['hpsa']['hdlmzip']}" do
  source "#{node['hpsa']['share']}\\#{node['hpsa']['hdlmzip']}"
  action :create
end

windows_zipfile "#{node['hpsa']['localpath']}\\#{node['hpsa']['hdlm']}" do
  source "#{node['hpsa']['localpath']}\\#{node['hpsa']['hdlmzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'install_hdlm' do
  guard_interpreter :powershell_script
  code "#{node['hpsa']['localpath']}\\#{node['hpsa']['hdlm']}\\Install_HDLM.bat"
  #not_if ""
end
