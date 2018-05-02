network_interface '#{node['dns_dtc']['netinterface']}' do
  dns '#{node['dns_dtc']['dns_servers']}'
end
