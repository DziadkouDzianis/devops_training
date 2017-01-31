sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd –-reload
sudo cp /vagrant/mod_jk.so /etc/httpd/modules/
sudo sh -s  
sudo echo 'worker.list=lb, status
worker.lb.type=lb
worker.lb.balance_workers=tomcat1, tomcat2
worker.tomcat1.host=172.192.10.31
worker.tomcat1.port=8009
worker.tomcat1.type=ajp13
worker.tomcat2.host=172.192.10.32
worker.tomcat2.port=8009
worker.tomcat2.type=ajp13
worker.status.type=status' > /etc/httpd/conf/workers.properties 
sudo echo 'LoadModule jk_module modules/mod_jk.so
JkWorkersFile conf/workers.properties
JkShmFile /tmp/shm
JkLogFile logs/mod_jk.log
JkLogLevel info
JkMount /* lb' >> /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd
exit

#Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y
#Install Groovy
sudo yum install groovy -y
##Install gradle
# sudo yum install unzip
# cd /opt
# sudo wget https://services.gradle.org/distributions/gradle-3.1-bin.zip
# sudo unzip gradle-3.1-bin.zip
# sudo ln -s gradle-3.1 gradle
# sudo vim /etc/profile.d/gradle-env.sh
export GRADLE_HOME=/opt/gradle
export PATH=$PATH:$GRADLE_HOME/bin
# sudo source /etc/profile.d/gradle-env.sh