#
# Cookbook:: book2
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Add image
docker_image '172.192.10.30:5000/task4' do
  repo '172.192.10.30:5000/task4'
  tag '0.020'
  action :pull  
end

# Add container
docker_container 'reg' do
  repo '172.192.10.30:5000/task4'
  tag '0.020'
  action :run
end
