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

node['install_asm']['disks'].each do |disk|
  if `fdisk -l 2> /dev/null | grep '#{disk}'`
    bash "create partition" do
      code "(echo n; echo p; echo 1; echo; echo; echo w) | fdisk #{disk}"
      action :run
      not_if {partprobe -d -s #{disk}}
    end
  end
end
