directory "#{node['install_ocm']['localpath']}" do
  action :create
end

powershell_script 'copy_ocm' do
  guard_interpreter :powershell_script
  code "Copy-Item -Recurse -Path #{node['install_ocm']['share']} -destination #{node['install_ocm']['localpath']}"
  not_if "Test-Path -Path #{node['install_ocm']['localpath']}\\#{node['install_ocm']['folder']}"
end


powershell_script 'install_ocm' do
  guard_interpreter :powershell_script
  code "#{node['install_ocm']['localpath']}\\#{node['install_ocm']['folder']}\\install_ocm.bat"
  #not_if ""
end
