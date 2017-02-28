#
# Cookbook:: book2
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Add image
docker_image '172.192.10.30:5000/task4' do
  repo "#{node[:book2][:img]}"
  tag "#{node[:book2][:vers]}"
  action :pull  
end

# Add container
docker_container 'tag' do
#  repo '172.192.10.30:5000/task4'
  repo "#{node[:book2][:img]}"
  tag "#{node[:book2][:vers]}"
  action :run
end

#  repo '172.192.10.30:5000/task4'
