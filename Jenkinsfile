def getVersion() {
	def propsString = readFile "gradle.properties"
	def props = new Properties()
	props.load(new StringReader(propsString))
	props.get("minor_version") + props.get("major_version")
	}
node {
	stage 'Git clone'   
		sh 'git clone https://github.com/DziadkouDzianis/devops_training.git -b task3'
	stage 'Give permission' 
		dir('devops_training') 
		{sh 'chmod +x gradlew && chmod +x gradle.properties' 
	stage 'Build gradle'  
		sh './gradlew build'
	stage 'Pull to GitHub' 
		withCredentials([usernamePassword(credentialsId: 'pull', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
		sh 'git add .'
		sh 'git config user.email dziadkou.dzianis@gmail.com'
		sh 'git config user.name admin'
		sh("git commit -am.")
		sh("git push https://${USERNAME}:${PASSWORD}@github.com/DziadkouDzianis/devops_training.git")   }
		}
	stage 'Upload to Nexus'
		dir('devops_training') {
		def vBuild = getVersion()
		withCredentials([usernamePassword(credentialsId: 'nexus', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
		sh("curl -u ${USERNAME}:${PASSWORD} -XPUT -T ./build/libs/task3.war http://172.192.10.30:8081/nexus/content/repositories/releases/task3/$vBuild/task3.war")
			}
		}
	stage 'Stop tomcat1'
		httpRequest httpMode: 'POST', url: 'http://172.192.10.30/jkmanager/?cmd=update&from=list&w=lb&sw=tomcat1&vwa=1'
	stage 'Deploy to tomcat1'
		dir('devops_training')	{
			def vBuild = getVersion()
			withCredentials([usernamePassword(credentialsId: 'jenkins', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
			sh("curl -u $USERNAME:$PASSWORD -T /usr/local/sonatype-work/nexus/storage/releases/task3/$vBuild/task3.war 'http://172.192.10.31:8080/manager/text/deploy?path=/task3-$vBuild'")
			    }
		    }
	stage 'Check the version'
		dir('devops_training')	{
		def vBuild = getVersion() //del
<<<<<<< HEAD
		def gradle_war=sh returnStdout: true, script: "cat ./gradle.properties"
			//echo gradle_war
	//	def page1 = sh returnStdout: true, script: "curl -s http://172.192.10.31:8080/task3-$vBuild/"
			//echo page1 
		def tomcat_war1=sh returnStdout: true, script: "curl -s http://172.192.10.31:8080/task3-$vBuild/ | sed 's/<[^>]*>//g'"
			//echo tomcat_war1
		echo 'gradle_war bellow'
		echo gradle_war
		echo 'tomcat_war1 bellow'
		echo tomcat_war1
			if (tomcat_war1.trim() == gradle_war.trim())
=======
		def gradle_war=sh("cat ./gradle.properties")
			//echo gradle_war
		def page1 = sh("curl -s http://172.192.10.31:8080/task3-$vBuild/")
			//echo page1 
		def tomcat_war1=sh("curl -s http://172.192.10.31:8080/task3-$vBuild/ | sed 's/<[^>]*>//g'")
			//echo tomcat_war1
			if (tomcat_war1 == gradle_war)
>>>>>>> 42976ec3cdb9316f5e3e2778a804c2a00fa737f0
				{ echo '---------Tomcat1 is good----------'
            }
			else { echo '------------Tomcat1 is bad-----------'
            }
		}
	stage 'Start tomcat1'
		httpRequest httpMode: 'POST', url: 'http://172.192.10.30/jkmanager/?cmd=update&from=list&w=lb&sw=tomcat1&vwa=0'
//Tomcat1 - new version, tomcat2 - old version
	stage 'Stop tomcat2'
		httpRequest httpMode: 'POST', url: 'http://172.192.10.30/jkmanager/?cmd=update&from=list&w=lb&sw=tomcat2&vwa=1'
	stage 'Deploy to tomcat2'
		dir('devops_training') {
		def vBuild = getVersion() //del
		withCredentials([usernamePassword(credentialsId: 'jenkins', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
		sh("curl -u $USERNAME:$PASSWORD -T /usr/local/sonatype-work/nexus/storage/releases/task3/$vBuild/task3.war 'http://172.192.10.32:8080/manager/text/deploy?path=/task3-$vBuild'")
			}
		}
	stage 'Check the version'
		dir('devops_training') 	{
		def vBuild = getVersion() //del
<<<<<<< HEAD
		def gradle_war=sh returnStdout: true, script: "cat ./gradle.properties"
			//echo gradle_war
		def tomcat_war2= sh returnStdout: true, script: "curl -s http://172.192.10.32:8080/task3-$vBuild/ | sed 's/<[^>]*>//g'"
			//echo tomcat_war2
		echo 'gradle_war bellow'
		echo gradle_war
		echo 'tomcat_war2 bellow'
		echo tomcat_war2
		if (tomcat_war2.trim() == gradle_war.trim())
=======
		def gradle_war=sh("cat ./gradle.properties")
			//echo gradle_war
		def page2 = sh("curl -s http://172.192.10.32:8080/task3-$vBuild/")
			//echo page2 
		def tomcat_war2=sh("curl -s http://172.192.10.32:8080/task3-$vBuild/ | sed 's/<[^>]*>//g'")
			//echo tomcat_war2
		if (tomcat_war2 == gradle_war)
>>>>>>> 42976ec3cdb9316f5e3e2778a804c2a00fa737f0
				{ echo '----------Tomcat2 is good----------'
            }
			else { echo '------------Tomcat2 is bad---------'
			}
		}
	stage 'Start tomcat2'
		httpRequest httpMode: 'POST', url: 'http://172.192.10.30/jkmanager/?cmd=update&from=list&w=lb&sw=tomcat2&vwa=0'
//Tomcat1 - new version, tomcat2 - new version
	stage 'Pull to GitHub' 
		dir('devops_training')	{
		def vBuild = getVersion() //del
		withCredentials([usernamePassword(credentialsId: 'pull', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
		sh 'git add -A'
		sh("git commit -am 'Increment to Jenkins $vBuild'")
		sh("git push https://${USERNAME}:${PASSWORD}@github.com/DziadkouDzianis/devops_training.git")   
		}
	}
}