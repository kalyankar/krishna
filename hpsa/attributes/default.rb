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

default['hpsa']['hdlmzip'] = 'HDLM_8.4.zip'
default['hpsa']['hdlm'] = 'HDLM_8.4'

default['hpsa']['netmonzip'] = 'netmon_w2k8_x64new.zip'
default['hpsa']['netmon'] = 'netmon'

default['hpsa']['tbmrzip'] = 'TBMR_7.1.3.zip'
default['hpsa']['tbmr'] = 'TBMR_7.1.3'
