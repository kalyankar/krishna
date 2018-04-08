rpm_package node['install_asm']['asm_support'] do
  source :#{node['install_asm']['asm_support']}
  action :install
end

yum_package 'kmod-oracleasm' do
  action :install
end

rpm_package node['install_asm']['asm_lib'] do
  source :#{node['install_asm']['asm_lib']}
  action :install
end
