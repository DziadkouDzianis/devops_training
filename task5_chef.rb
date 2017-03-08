##TO install chef core, chef manage, chef DK  chef-server-core-12.13.0-1.el7.x86_64.rpm    chef-manage-2.4.4-1.el7.x86_64.rpm    chefdk-1.2.22-1.el7.x86_64.rpm
##should exists in /vagrant/

# Chef credentials login: dzianis, password: admin123

##Install chef server
sudo mv chef-server-core-12.13.0-1.el7.x86_64.rpm /tmp
sudo rpm -Uvh /tmp/chef-server-core-12.13.0-1.el7.x86_64.rpm
#If it is necessary cleanse chef befoore reconfigure
#sudo chef-server-ctl cleanse
sudo chef-server-ctl reconfigure
#If pivotal.pem is not exists copy it
#cd /etc/opscode
#sudo mv pivotal.pem ..

#Add organization and name
#sudo chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME
sudo chef-server-ctl user-create admin dzianis dziadkou dziadkou.dzianis@gmail.com 'admin123' --filename /vagrant/dzianis.pem
#sudo chef-server-ctl org-create short_name 'full_organization_name' --association_user user_name --filename ORGANIZATION-validator.pem
sudo chef-server-ctl org-create d_enterp 'Dzianis Enterpise' --association_user admin --filename /vagrant/d_enterp-validator.pem
#sudo chef-server-ctl org-user-add ORG_NAME USER_NAME --admin
sudo chef-server-ctl org-user-add d_enterp avm --admin

#Install chef manage
sudo rpm -Uvh /vagrant/chef-manage-2.4.4-1.el7.x86_64.rpm
sudo chef-manage-ctl reconfigure
#yes

git config --global user.name admin
git config --global user.email dziadkou.dzianis@gmail.com
#Install chef DK
sudo rpm -Uvh /vagrant/chefdk-1.2.22-1.el7.x86_64.rpm
chef verify
chef -v

#Install Ruby
sudo yum install ruby -y

#Update bash_profile. Use next command 
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
# OR 
# sudo vi ./home/vagrant/.bash_profile
# Change this: PATH=$PATH:$HOME/.local/bin:$HOME/bin
# to this: PATH=$PATH:$HOME/opt/chefdk/embedded/bin:$HOME/bin

# restart machine
# "which ruby"  shows  "/opt/chefdk/embedded/bin/ruby"
#Install PowerShell
chef shell-init powershell | Invoke-Expression
#sudo vi /etc/hosts > '172.192.10.30	avm	avm'		 echo '172.192.10.30   chef.domain.com chef' >> /etc/hosts		##by hand

##Starter Kit
#Generate application chef-repo
chef generate app chef-repo
mkdir -p ~/chef-repo/.chef
echo '.chef' >> ~/chef-repo/.gitignore
cp /vagrant/chef-repo/.chef/knife.rb ~/chef-repo/.chef
cp /vagrant/d_enterp-validator.pem ~/chef-repo/.chef
cp /vagrant/dzianis.pem ~/chef-repo/.chef
echo "validation_client_name   'ORG_NAME-validator'" >> ~/chef-repo/.chef/knife.rb 	##?? ORG_NAME ?
echo "validation_key           \"#{current_dir}/d_enterp-validator.pem\"" >> ~/chef-repo/.chef/knife.rb
echo "cache_type               'BasicFile'" >> ~/chef-repo/.chef/knife.rb
echo "cache_options( :path => \"#{ENV['HOME']}/.chef/checksums\" )" >> ~/chef-repo/.chef/knife.rb
sed -i "s/\#{current_dir}\/admin/\#{current_dir}\/dzianis/g" ~/chef-repo/.chef/knife.rb
sed -i "s/\#{current_dir}\/dzianis/\#{current_dir}\/admin/g" ~/chef-repo/.chef/knife.rb
#Modify bash_profile
echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

##Get SSL Certificates
cd /vagrant/
cp -r chef-repo ~
sudo cp d_enterp-validator.pem /home/vagrant/chef-repo/.chef
sudo mkdir trusted_certs
sudo cp /var/opt/opscode/nginx/ca/avm.crt /home/vagrant/chef-repo/.chef/trusted_certs
knife ssl check

##Add nodes addresses to hosts file  	by hand
#echo "172.192.10.1    node1	node1" >> /etc/hosts
#echo "172.192.10.2    node2	node2" >> /etc/hosts

# Add node1 
knife bootstrap 172.192.10.31 -N node1 -x root	
# Add node2
knife bootstrap 172.192.10.32 -N node2 -x root

## Add roles
knife role create docker_install_role -e vi
#"description": "This role is created to install Docker",
#"run_list": ["recipe[book1]"],
knife role create docker_run_role -e vi
#"description": "This role is created to run Docker images",
#"run_list": ["role[docker_install_role]", "recipe[book2]"],

##1. Create cookbooks
cd /home/vagrant/chef-repo/cookbooks
sudo chef generate cookbook book1
sudo chef generate cookbook book2
# Upload to the chef-server
# Add "depends 'docker', '~> 2.0'" to metadata.rb by hands
cd /home/vagrant/chef-repo/cookbooks/book1
sudo berks install
sudo berks upload

sudo yum remove container-selinux -y #tomcat1_machine
knife bootstrap 172.192.10.31 --sudo --use-sudo-password --node-name node1 --run-list 'recipe[book1]' -y -y 
knife bootstrap 172.192.10.32 --sudo --use-sudo-password --node-name node2 --run-list 'role[docker_run_role]' -y -y 

echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf	##by hand






sudo vi ./var/opt/opscode/nginx/etc/chef_https_lb.conf
vi /etc/hosts

#  insecure_registry 'https://172.192.10.30:5000'
repo "#{node[:book2][:img]}"

default[:book2][:img] = "172.192.10.30:5000/task4"
sudo grep -ir "^jk" /etc/httpd/*












