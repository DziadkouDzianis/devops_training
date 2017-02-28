#
# Cookbook:: book1
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved
# Install docker
docker_service 'default' do
  ipv4_forward true
  insecure_registry "#{node[:book1][:ins_reg]}"
  action [:create, :start]
end
