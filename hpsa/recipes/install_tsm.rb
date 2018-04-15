remote_file "#{node['hpsa']['localpath']}\\#{node['hpsa']['tsmzip']}" do
  source "#{node['hpsa']['share']}\\#{node['hpsa']['tsmzip']}"
  action :create
end

windows_zipfile "#{node['hpsa']['localpath']}\\#{node['hpsa']['tsm']}" do
  source "#{node['hpsa']['localpath']}\\#{node['hpsa']['tsmzip']}"
  action :unzip
  #overwrite true
end

powershell_script 'ISSetupPrerequisitesA' do
  guard_interpreter :powershell_script
  code "\"#{node['hpsa']['localpath']}\\#{node['hpsa']['tsm']}\\ISSetupPrerequisites\\{270b0954-35ca-4324-bbc6-ba5db9072dad}\\vcredist_x86.exe\" /q /c:\"msiexec /i vcredist.msi /qn /l*v %temp%\\vcredist_2010_x86.log\""
  #not_if ""
end

powershell_script 'ISSetupPrerequisitesB' do
  guard_interpreter :powershell_script
  code "\"#{node['hpsa']['localpath']}\\#{node['hpsa']['tsm']}\\ISSetupPrerequisites\\{7f66a156-bc3b-479d-9703-65db354235cc}\\vcredist_x64.exe\" /q /c:\"msiexec /i vcredist.msi /qn /l*v %temp%\\vcredist_2010_x64.log\""
  #not_if ""
end

powershell_script 'ISSetupPrerequisitesC' do
  guard_interpreter :powershell_script
  code "\"#{node['hpsa']['localpath']}\\#{node['hpsa']['tsm']}\\ISSetupPrerequisites\\{270b0954-35ca-4324-bbc6-ba5db9072dad}\\vcredist_x86.exe\" /q /c:\"msiexec /i vcredist.msi /qn /l*v %temp%\\vcredist_2012_x86.log\"" 
  #not_if ""
end

powershell_script 'ISSetupPrerequisitesD' do
  guard_interpreter :powershell_script
  code "\"#{node['hpsa']['localpath']}\\#{node['hpsa']['tsm']}\\ISSetupPrerequisites\\{7f66a156-bc3b-479d-9703-65db354235cc}\\vcredist_x64.exe\" /q /c:\"msiexec /i vcredist.msi /qn /l*v %temp%\\vcredist_2012_x64.log\""
  #not_if ""
end

powershell_script 'install_tsm' do
  guard_interpreter :powershell_script
  code "msiexec /i \"#{node['hpsa']['localpath']}\\#{node['hpsa']['tsm']}\\IBM Tivoli Storage Manager Client.msi\" RebootYesNo=\"No\" REBOOT=\"Suppress\" ALLUSERS=1 ADDLOCAL=\"BackupArchiveGUI,BackupArchiveWeb,Api64Runtime,AdminAdministrativeCmd\"  /qn /l*v \"C:\build\tsm_install.log\""
  #not_if ""
end
