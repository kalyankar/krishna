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

bash "configure asm" do
  code "(echo #{node['install_asm']['user']}; echo #{node['install_asm']['group']}; echo "y"; echo "y") | /etc/init.d/oracleasm configure"
  action :run
end

node['install_asm']['disks'].each do |disk|
  if `fdisk -l 2> /dev/null | grep '#{disk}'`
    bash "create partition" do
      code "(echo n; echo p; echo 1; echo; echo; echo w) | fdisk #{disk}"
      action :run
      not_if {"partprobe -d -s #{disk}"}
    end
  end
end

node['install_asm']['disks'].each do |disk|
  bash "Mark ASM Disks" do
    code "#{node['install_asm']['asm_file']} createdisk #{node['install_asm']['group']} #{disk}1"
    action :run
    not_if "#{node['install_asm']['asm_file']} querydisk #{disk}1"
  end
end

bash "asm scan disk" do
  code "#{node['install_asm']['asm_file']} scandisks"
  action :run
end

bash "asm list disk" do
  code "#{node['install_asm']['asm_file']} listdisks"
  action :run
end
