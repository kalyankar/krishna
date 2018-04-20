Hi Bro,
Here the requirement is a bit complex. It has to copy SSL certificate from Windows NAS share to Linux Server.
By default Linux cannot access Windows share. So we have to mount the Windows NAS Share on Linux server then access the files from mount point.
Since Windows requires Authentication from accessing any of its resources, we have to explicitly provide the credentials of the Windows server.
So the additional details like Windows UserID, Windows Domain, Windows UserID Password are required in order to add the mount point.

In attributes/default.rb, below are the inputs required:

default['sdcs']['ofe]']['share'] = '\\\\nasv3701.optumfe.com\\DyUFdAGB'
default['sdcs']['ofe]']['windows_user'] = '<need windows user id here>'
default['sdcs']['ofe]']['windows_domain'] = '<need windows domain here>'
default['sdcs']['ofe]']['windows_userpass'] = '<need windows user password here>'

in the above, password cannot be provided just like that so we can encrypt using our encryption algorithms
Below is the code that needs to be replaced SDCS in windows recipe with remote_file block because Linux cannot access Windows NAS Share folders directly, we have to mount the share folder before accessing it.
I have tested the below code and it works fine for me in my environment. 

#Code starts Here

directory '/tmp/mntofe' do
  mode '0777'
  action :create
end

bash 'mount_windows_share' do

 code <<-EOH
  mount -t cifs #{node['sdcs']['ofe]']['share']} /tmp/mntofe -o user=#{node['sdcs']['ofe]']['windows_user']},domain=#{node['sdcs']['ofe]']['windows_domain']},password=#{node['sdcs']['ofe]']['windows_userpass']}
  cp /tmp/mntofe/ofe-agent-cert.ssl /tmp
 EOH
not_if { grep '/tmp/mntofe' /proc/mounts }
end

bash 'copy_ssl' do

 code <<-EOH
  cp /tmp/mntofe/ofe-agent-cert.ssl /tmp
 EOH
only_if { grep '/tmp/mntofe' /proc/mounts }
end

bash 'umount_windows_share' do

 code <<-EOH
  umount /tmp/mntofe
 EOH
only_if { grep '/tmp/mntofe' /proc/mounts }
end

#Code ends here

There is another way to do this as well. But the SSL needs to be placed in Web Server like Apache, NGNIX or IIS instead of Windows Share.
If the SSL certificate is placed on Web Server, we would require the URL some thing which looks like "http://www.nasv3701.optumfe.com/ofe-agent-cert.ssl"

if the SSL certificate is placed on web server it is easier to copy to our Linux Servers.

In attributes/default.rb, below are the inputs required:

default['sdcs']['ofe]']['ssl_cert_web'] = "http://www.nasv3701.optumfe.com/ofe-agent-cert.ssl"

The code for coping SSL Certificate from a Web Server is below:

#Code starts here

bash 'copy_ofe_ssl' do
  cwd '/tmp'
  code <<-EOH
  wget #{node['sdcs']['ofe]']['ssl_cert_web']}
  EOH
end

#Code ends here


There is a third way to do this as well i.e. to copy from a Linux server to Linux server using SCP

In attributes/default.rb, below are the inputs required:

default['sdcs']['ofe]']['ssl_server'] = "nasv3701.optumfe.com:/<path>/<to>/<ssl>"
default['sdcs']['ofe]']['linux_user'] = "<user_name_here>"

#Code starts here

bash 'copy_ofe_ssl' do
  cwd '/tmp'
  code <<-EOH
  scp #{node['sdcs']['ofe]']['linux_user']}@#{node['sdcs']['ofe]']['ssl_server']} ofe-agent-cert.ssl
  EOH
end

#Code ends here

That's it bro. more than this we can't do any this. if the three are not working they have to provide the ssl in cookbook. 
