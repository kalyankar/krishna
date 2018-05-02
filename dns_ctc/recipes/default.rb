network_interface '#{node['dns_ctc']['netinterface']}' do
  dns '#{node['dns_ctc']['dns_servers']}'
end
