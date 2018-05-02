directory "#{node['citrix']['folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['folder']}\\#{node['citrix']['admin_to_local_zip']}" do
  source "#{node['citrix']['share']}\\#{node['citrix']['admin_to_local_zip']}"
  action :create
end

windows_zipfile "#{node['citrix']['folder']}" do
  source "#{node['citrix']['folder']}\\#{node['citrix']['admin_to_local_zip']}"
  action :unzip
  #overwrite true
end

case node['citrix']['env']
when 'PROD-CORP'
  powershell_script 'ADD_ADM_TO_LOCAL' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\SCR_Citrix_Add_adm_To_Local_Admins_Group\\SCR_Citrix_Add_xa7prod_adm_To_Local_Admins_Group.ps1"
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*IE11*'}"
    
  end
  when 'PROD-CCD'
  powershell_script 'ADD_ADM_TO_LOCAL' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\SCR_Citrix_Add_adm_To_Local_Admins_Group\\SCR_Citrix_Add_xa7prodccd_adm_To_Local_Admins_Group.ps1"
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*IE11*'}"
    
  end
  when 'STAGE'
  powershell_script 'ADD_ADM_TO_LOCAL' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\SCR_Citrix_Add_adm_To_Local_Admins_Group\\SCR_Citrix_Add_xa7stage_adm_To_Local_Admins_Group.ps1"
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*IE11*'}"
    
  end
  when 'DEV'
  powershell_script 'ADD_ADM_TO_LOCAL' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\SCR_Citrix_Add_adm_To_Local_Admins_Group\\SCR_Citrix_Add_xa7dev_adm_To_Local_Admins_Group.ps1"
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*IE11*'}"
    
  end
  when 'TEST'
  powershell_script 'ADD_ADM_TO_LOCAL' do
    guard_interpreter :powershell_script
    code "#{node['citrix']['folder']}\\SCR_Citrix_Add_adm_To_Local_Admins_Group\\SCR_Citrix_Add_xa7test_adm_To_Local_Admins_Group.ps1"
    #not_if "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | where {$_.Displayname -like '*IE11*'}"
    
  end
  end
