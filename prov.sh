sudo yum install java-1.8.0-openjdk -y
sudo yum install tomcat tomcat-webapps tomcat-admin-webapps -y
sudo systemctl enable tomcat 
sudo systemctl start tomcat 
sudo echo '<tomcat-users>
<!--
  <role rolename="tomcat"/>
  <role rolename="role1"/>
  <role rolename="manager-script"/>
  <user username="tomcat" password="tomcat" roles="tomcat"/>
  <user username="both" password="tomcat" roles="tomcat,role1"/>
  <user username="role1" password="tomcat" roles="role1"/>
-->

        <role rolename="manager-gui"/>
        <user username="admin" password="admin" roles="manager-gui,manager-script"/>

</tomcat-users>' > /etc/tomcat/tomcat-users.xml
sudo systemctl restart tomcat