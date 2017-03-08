#
# Cookbook:: book3
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved



url = "http://172.192.10.32:8080/task3/ | sed 's/<[^>]*>//g'"

execute 'forward_ipv4' do
  command "curl #{url}"
  action :nothing
end
