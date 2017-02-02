# -*- mode: ruby -*-
# vi: set ft=ruby :
$s1 = <<SCRIPT
sudo sh -s
sudo echo 'Server 1' > /usr/share/tomcat/webapps/ROOT/server.html
exit
SCRIPT
$s2 = <<SCRIPT
sudo sh -s
sudo echo 'Server 2' > /usr/share/tomcat/webapps/ROOT/server.html
exit
SCRIPT

Vagrant.configure("2") do |config|
	config.vm.box = "bertvv/centos72"
		config.vm.provider "virtualbox" do |vb|
		config.vm.provision "shell", path: "all_prov.sh"
	end		
	config.vm.define "avm" do |avm|
		avm.vm.hostname = "avm"
		avm.vm.network "private_network", ip: "172.192.10.30"	
		avm.vm.network "forwarded_port", guest: 22, host: 2220, id: "ssh"	
		avm.vm.network "forwarded_port", guest: 80, host: 8000	
		avm.vm.provision "shell", path: "avm.sh"
		avm.vm.provision "shell", path: "nexus.sh"	#http://172.192.10.30:8081/nexus/#welcome
	#127.0.0.1.:2222
	end
	
	config.vm.define "tomcat1" do |tomcat1|
		tomcat1.vm.hostname = "tomcat1"
		tomcat1.vm.network "private_network", ip: "172.192.10.31"	
		tomcat1.vm.network "forwarded_port", guest: 22, host: 2221, id: "ssh"	
		tomcat1.vm.network "forwarded_port", guest: 8080, host: 8001	
		tomcat1.vm.provision "shell", path: "prov.sh"
		tomcat1.vm.provision "shell", inline: $s1
	#127.0.0.1.:2200
	end
	
	config.vm.define "tomcat2" do |tomcat2|
		tomcat2.vm.hostname = "tomcat2"
		tomcat2.vm.network "private_network", ip: "172.192.10.32"
		tomcat2.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh"	
		tomcat2.vm.network "forwarded_port", guest: 8080, host: 8002			
		tomcat2.vm.provision "shell", path: "prov.sh"
		tomcat2.vm.provision "shell", inline: $s2
	#127.0.0.1.:2201
	end
end