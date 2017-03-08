#
# Cookbook:: book2
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


require 'socket'
require 'timeout'

ports = ['8080', '8081']
def port_open?(ip, port)
begin
   Timeout.timeout(0.5) do
      begin
         TCPSocket.new(ip, port)
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, SocketError
	retry      
      end
    end
  rescue Timeout::Error
 
#if port_open?("172.192.10.32", ports[1])
#   docker_container 'tag0' do
#     repo '172.192.10.30:5000/task4'
#      repo "#{node[:book2][:img]}"
#      tag "#{node[:book2][:vers]}"
#      port "8080:8080"
#      action :run
#    end
#     docker_container 'tag1' do
#      action [:stop, :delete]
#  end  
 end
end


# Blue Green Development

if port_open?("172.192.10.32", ports[0])
     docker_container 'tag1' do
      repo '172.192.10.30:5000/task4'
      repo "#{node[:book2][:img]}"
      tag "#{node[:book2][:vers]}"
      port "#{ports[1]}:8080"
      action :run
  end
     docker_container 'tag0' do
      action [:stop, :delete]
    end
elsif port_open?("172.192.10.32", ports[1]) 
      docker_container 'tag0' do
     repo '172.192.10.30:5000/task4'
     repo "#{node[:book2][:img]}"
     tag "#{node[:book2][:vers]}"
     port "#{ports[0]}:8080"
     action :run
   end
    docker_container 'tag1' do
     action [:stop, :delete]
    end     
end
