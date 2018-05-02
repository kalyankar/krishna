directory "#{node['citrix']['folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['folder']}\\#{node['citrix']['vda_server_setup_zip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['vda_server_setup_zip']}"
  action :create
end

windows_zipfile "#{node['citrix']['folder']}" do
  source "#{node['citrix']['folder']}\\#{node['citrix']['vda_server_setup_zip']}"
  action :unzip
  #overwrite true
end

case node['citrix']['env']
when 'PROD-CORP'
  powershell_script 'install_vda' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\VDAServerSetup_7_15_2000\\VDAServerSetup_7_15_2000.exe /quiet /components vda /exclude "Personal vDisk","Machine Identity Service" /controllers "wtxep4269.ms.ds.uhc.com wtxep4555.ms.ds.uhc.com wtxep4557.ms.ds.uhc.com wtxep4571.ms.ds.uhc.com wtxep5972.ms.ds.uhc.com wtxep6169.ms.ds.uhc.com" /enable_real_time_transport /enable_hdx_ports /enable_hdx_udp_ports /optimize /enable_remote_assistance /noreboot /logpath "C:\\citrix\\installs\\XenApp""
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*VDA*'}"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately
  end
  when 'PROD-CCD'
  powershell_script 'install_vda' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\VDAServerSetup_7_15_2000\\VDAServerSetup_7_15_2000.exe /quiet /components vda /exclude "Personal vDisk","Machine Identity Service" /controllers "wtxep7333.ms.ds.uhc.com wtxep7335.ms.ds.uhc.com wtxep7336.ms.ds.uhc.com wtxep7337.ms.ds.uhc.com wtxep7338.ms.ds.uhc.com" /enable_real_time_transport /enable_hdx_ports /enable_hdx_udp_ports /optimize /enable_remote_assistance /noreboot /logpath "C:\\citrix\\installs\XenApp""
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*VDA*'}"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately
  end
  when 'STAGE'
  powershell_script 'install_vda' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\VDAServerSetup_7_15_2000\\VDAServerSetup_7_15_2000.exe /quiet /components vda /exclude "Personal vDisk","Machine Identity Service" /controllers "wtxes0023.ms.ds.uhc.com wtxes0046.ms.ds.uhc.com wtxes0050.ms.ds.uhc.com wtxes0159.ms.ds.uhc.com" /enable_real_time_transport /enable_hdx_ports /enable_hdx_udp_ports /optimize /enable_remote_assistance /noreboot /logpath "C:\\citrix\\installs\\XenApp""
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*VDA*'}"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately
  end
  when 'DEV'
  powershell_script 'install_vda' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\VDAServerSetup_7_15_2000\\VDAServerSetup_7_15_2000.exe /quiet /components vda /exclude "Personal vDisk","Machine Identity Service" /controllers "wtxed0409.ms.ds.uhc.com wtxed0411.ms.ds.uhc.com wtxed0417.ms.ds.uhc.com" /enable_real_time_transport /enable_hdx_ports /enable_hdx_udp_ports /optimize /enable_remote_assistance /noreboot /logpath "C:\\citrix\\installs\\XenApp""
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*VDA*'}"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately
  end
  when 'TEST'
  powershell_script 'install_vda' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\VDAServerSetup_7_15_2000\\VDAServerSetup_7_15_2000.exe /quiet /components vda /exclude "Personal vDisk","Machine Identity Service" /controllers "wtxet0034.ms.ds.uhc.com wtxet0035.ms.ds.uhc.com" /enable_real_time_transport /enable_hdx_ports /enable_hdx_udp_ports /optimize /enable_remote_assistance /noreboot /logpath "C:\\citrix\\installs\\XenApp""
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*VDA*'}"
    notifies :reboot_now, 'reboot[reboot_server]', :immediately
  end
  end
