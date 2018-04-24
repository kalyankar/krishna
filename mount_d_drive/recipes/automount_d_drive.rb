

file_loc = Chef::Config['file_cache_path']
is_d_drive_present = false
drives = node['filesystem']
drv_list = drives.to_a

# Copy D-drive initialize ps1 script to chef cache
template "#{file_loc}\\init_d_drive.ps1" do
  source 'init_d_drive.ps1.erb'
  action :create
end
# To set the Execution policy in the Server
powershell_script 'Set Execution Policy' do
  guard_interpreter :powershell_script
  code 'set-executionpolicy -scope localmachine remotesigned'
  not_if "(get-executionpolicy -scope localmachine) -eq 'remotesigned'"
end
ruby_block 'Set D-Drive' do
  block do
    drv_list.each do |item|
      if item[0] == 'D:'
        Chef::Log.info 'D-drive is already present'
        is_d_drive_present = true
        break
      end
    end
    unless is_d_drive_present
      Chef::Log.info is_d_drive_present
      exec "C:/Windows/sysnative/WindowsPowerShell/v1.0/powershell.exe #{file_loc}\\init_d_drive.ps1 D"
    end
  end
  action :run
end
