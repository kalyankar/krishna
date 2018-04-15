# Following are the attributes for HPSA Packages installation.

default['hpsa']['share'] = '\\NAS4HPSA1\HPSA media windows\Packages'

#default['hpsa']['share'] = '\\\\NAS4HPSA1\\HPSA media windows\\Packages'
#default['hpsa']['share'] = "\\NAS4HPSA1\HPSA media windows\Packages"
#default['hpsa']['share'] = "\\\\NAS4HPSA1\\HPSA media windows\\Packages"

default['hpsa']['localpath'] = 'C:\build'
#default['hpsa']['localpath'] = 'C:\\build'
#default['hpsa']['localpath'] = "C:\build"
#default['hpsa']['localpath'] = "C:\\build"

default['hpsa']['hpsumzip'] = 'sppaug282016.zip'
default['hpsa']['hpsum'] = 'sppaug282016'

default['hpsa']['tsmzip'] = 'TSM_7.1.4.zip'
default['hpsa']['tsm'] = 'TSM_7.1.4'
