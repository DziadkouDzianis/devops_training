#
# Cookbook:: book1
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved

# Install docker

# Install docker
docker_service 'default' do
  ipv4_forward true
  insecure_registry 'https://172.192.10.30:5000'
  action [:create, :start]
end

