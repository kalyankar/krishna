ruby_block 'encrypt' do
  block do
    require "base64"
	#for testing, puts i.e prints on the output is included, remove all the puts lines after testing
	ofe_rhel6 = Base64.decode64('Ly9uYXN2MzcwMS5vcHR1bWZlLmNvbS9EeVVGZEFHQi9hZ2VudDY0LWxpbnV4LXJoZWw2LmJpbg==')
	puts ofe_rhel6
	node.default['sdcs']['package']['ofe']['rhel_6'] = ofe_rhel
	
	ofe_rhel7 = Base64.decode64('Ly9uYXN2MzcwMS5vcHR1bWZlLmNvbS9EeVVGZEFHQi9hZ2VudDY0LWxpbnV4LXJoZWw3LmJpbg==')
	puts ofe_rhel7
	node.default['sdcs']['package']['ofe']['rhel_7'] = ofe_rhel7
	
	ofe_windows = Base64.decode64('XFxcXG5hc3YzNzAxLm9wdHVtZmUuY29tXFxEeVVGZEFHQlxcYWdlbnQuZXhl')
	puts ofe_windows
	node.default['sdcs']['package']['ofe']['windows'] = ofe_windows
	
	ofe_ssl_cert = Base64.decode64('XFxcXG5hc3YzNzAxLm9wdHVtZmUuY29tXFxEeVVGZEFHQlxcb2ZlLWFnZW50LWNlcnQuc3Ns')
	puts ofe_ssl_cert
	node.default['sdcs']['package']['ofe']['ssl_cert'] = ofe_ssl_cert
	
	ofe_management_server = Base64.decode64('MTAuMTU1LjY3LjU0LDEwLjE1NS42Ni4xMTEsMTAuMTU1LjEzMC4xNw==')
	puts ofe_management_server
	node.default['sdcs']['package']['ofe']['management_server'] = ofe_management_server
	
	ofe_install_opt = Base64.decode64('LXNpbGVudCAtcHJlZml4PS9vcHQvU3ltYW50ZWMgLXNlcnZlcj0xMC4xNTUuNjcuNTQgLWFsdHNlcnZlcnM9MTAuMTU1LjY2LjExMSwxMC4xNTUuMTMwLjE3IC1jZXJ0PS90bXAvZG16LWFnZW50LWNlcnQuc3NsIC1hZ2VudHBvcnQ9NDQzIC1sb2dkaXI9L3Zhci9sb2c=')
	puts ofe_install_opt
	node.default['sdcs']['package']['ofe']['install_opt'] = ofe_install_opt
	
  end
end