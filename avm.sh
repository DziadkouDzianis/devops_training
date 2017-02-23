sudo yum install vim -y	#vim install
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
JkMount /* lb
JkMount /jkmanager/* status' >> /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd
exit
