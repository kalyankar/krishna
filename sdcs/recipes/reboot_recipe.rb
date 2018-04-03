  execute 'reboot_after_install' do
    command "reboot"
    only_if "rpm -qa | grep SYMCsdcss"
  end
