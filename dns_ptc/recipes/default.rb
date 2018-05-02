network_interface '#{node['dns_ptc']['netinterface']}' do
  dns '#{node['dns_ptc']['dns_servers']}'
end
