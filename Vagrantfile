Vagrant.configure("2") do |config|
  config.vm.box = "bertvv/centos72"
  config.vm.provider "virtualbox" do |vb|
  #vb.customize ['modifyvm', :id, '--cableconnected1', 'on'] 
 end  
 config.vm.define "s1" do |server1|
  server1.vm.hostname = "s1"
  server1.vm.network "private_network", ip: "172.192.10.31"
   
 end
 
   
 config.vm.define "s2" do |server2|
  server2.vm.hostname = "s2"
  server2.vm.network "private_network", ip: "172.192.10.32"
 server2.vm.provision "yum", type: "shell",
  inline: "sudo yum install git -y && git clone https://github.com/DziadkouDzianis/devops_training.git && git checkout task1"
 end
 end