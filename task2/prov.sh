sudo yum install java-1.8.0-openjdk -y
sudo yum install tomcat tomcat-webapps tomcat-admin-webapps -y
sudo systemctl enable tomcat 
sudo systemctl start tomcat 