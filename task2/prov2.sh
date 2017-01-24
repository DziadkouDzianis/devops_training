sudo yum install java-1.8.0-openjdk -y
sudo yum install tomcat tomcat-webapps tomcat-admin-webapps -y
sudo systemctl restart network
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl enable tomcat 
sudo systemctl start tomcat 
sudo sh -s
sudo echo 'Server 2' > /usr/share/tomcat/webapps/ROOT/server.html
exit
