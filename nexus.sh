#Install Nexus
sudo yum install java -y
cd /vagrant/
sudo cp nexus-2.14.2-01-bundle.tar.gz /usr/local	#local path
#sudo wget https://sonatype-download.global.ssl.fastly.net/nexus/oss/nexus-2.14.2-01-bundle.tar.gz 		#link from the internet
cd /usr/local
sudo tar xvzf ./nexus-2.14.2-01-bundle.tar.gz
sudo ln -s nexus-2.14.2-01 nexus
sudo useradd nexus
sudo chown -R nexus:nexus nexus
cd /usr/local/nexus/bin
sudo vi nexus /NEXUS_HOME=".."
:%s/NEXUS_HOME=".."/NEXUS_HOME="\/usr\/local\/nexus"
:%s/#RUN_AS_USER=/RUN_AS_USER=nexus

ZZ
:q!

sudo
sudo ip addr
sudo cp ./nexus /etc/init.d/nexus
sudo chmod 755 /etc/init.d/nexus
sudo chown root /etc/init.d/nexus
sudo ./nexus start

#tail -f /usr/local/nexus/logs/wrapper.log
#http://172.192.10.30:8081/nexus/#welcome
#
#Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y
#Install Groovy
sudo yum install groovy -y
##Install gradle
sudo yum install unzip -y
cd /opt
sudo wget https://services.gradle.org/distributions/gradle-3.1-bin.zip
sudo unzip gradle-3.1-bin.zip
sudo ln -s gradle-3.1 gradle
#sudo vi /etc/profile.d/gradle-env.sh
#export GRADLE_HOME=/opt/gradle
#export PATH=$PATH:$GRADLE_HOME/bin
#
sudo echo 'GRADLE_HOME=/opt/gradle 
PATH=$PATH:$GRADLE_HOME/bin' > /etc/profile.d/gradle-env.sh
exit

#sudo source /etc/profile.d/gradle-env.sh
#http://172.192.10.30:8080/
#sudo vi /var/lib/jenkins/secrets/initialAdminPassword
#Copy Junkins HTTP Request plugin
sudo cd /vagrant/
sudo cp ./http_request.hpi /var/lib/jenkins/plugins
sudo systemctl restart jenkins


