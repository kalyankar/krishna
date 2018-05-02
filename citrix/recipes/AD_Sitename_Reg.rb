directory "#{node['citrix']['folder']}" do
  recursive true
  action :create
end

remote_file "#{node['citrix']['folder']}\\SCR_Citrix_AD_SiteName Reg Key.bat" do
  source "#{node['citrix']['share']}\\SCR_Citrix_AD_SiteName Reg Key.bat"
  action :create
end

batch 'ad_sitename_reg' do
  code <<-EOH
    SCR_Citrix_AD_SiteName Reg Key.bat
EOH
end
