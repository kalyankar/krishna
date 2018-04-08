

if node['platform_version'].to_i == 5

  cookbook_file "/tmp/#{node['fim']['package']['rhel_5']}" do
    source "rhel/#{node['fim']['package']['rhel_5']}"
  end 

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation of SDCS'
    delay_mins 2
  end

  bash "install_SYMCcsp" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_5']}
    /tmp/#{node['fim']['package']['rhel_5']} -silent 
    EOH
    action :run
    not_if "rpm -qa | grep SYMCcsp"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

  bash "install_SYMCcsp_version" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_5']}
    /tmp/#{node['fim']['package']['rhel_5']} -silent
    EOH
    action :run
    not_if "rpm -q --queryformat \'%{VERSION}-%{release}\n\' SYMCcsp | grep  "#{node['fim']['package_version']['rhel_5']}"  > /dev/null"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

  bash "install_SYMCsdcss" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_5']}
    /tmp/#{node['fim']['package']['rhel_5']} #{node['fim']['install_opt']}
    EOH
    action :run
    not_if "rpm -qa | grep SYMCsdcss"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

  bash "install_SYMCsdcss_version" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_5']}
    /tmp/#{node['fim']['package']['rhel_5']} -silent 
    EOH
    action :run
    not_if "rpm -q --queryformat \'%{VERSION}-%{release}\n\' SYMCsdcss | grep  "#{node['fim']['package_version']['rhel_5']}"  > /dev/null"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

end



if node['platform_version'].to_i == 6

  cookbook_file "/tmp/#{node['fim']['package']['rhel_6']}" do
    source "rhel/#{node['fim']['package']['rhel_6']}"
  end 

  reboot 'reboot_server' do
    action :nothing
    reason 'System needs a restart after installation of SDCS'
    delay_mins 2
  end

  bash "install_SYMCcsp" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_6']}
    /tmp/#{node['fim']['package']['rhel_6']} -silent 
    EOH
    action :run
    not_if "rpm -qa | grep SYMCcsp"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

  bash "install_SYMCcsp_version" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_6']}
    /tmp/#{node['fim']['package']['rhel_6']} -silent
    EOH
    action :run
    not_if "rpm -q --queryformat \'%{VERSION}-%{release}\n\' SYMCcsp | grep  "6.6.0-772" > /dev/null"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

  bash "install_SYMCsdcss" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_6']}
    /tmp/#{node['fim']['package']['rhel_6']} #{node['fim']['install_opt']}
    EOH
    action :run
    not_if "rpm -qa | grep SYMCsdcss"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

  bash "install_SYMCsdcss_version" do
    code <<-EOH
    chmod +rx /tmp/#{node['fim']['package']['rhel_6']}
    /tmp/#{node['fim']['package']['rhel_6']} -silent 
    EOH
    action :run
    not_if "rpm -q --queryformat \'%{VERSION}-%{release}\n\' SYMCsdcss | grep  "#{node['fim']['package_version']['rhel_6']}"  > /dev/null"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately	
  end

end
