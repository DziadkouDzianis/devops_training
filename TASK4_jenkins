def getVersion() {
	def propsString = readFile "gradle.properties"
	def props = new Properties()
	props.load(new StringReader(propsString))
	props.get("minor_version") + props.get("major_version")
	}
node ('master') {
	stage 'Git clone'   
		sh 'git clone https://github.com/DziadkouDzianis/devops_training.git -b task4'  
	stage 'Downlload from Nexus and build in Docker'
		dir ('devops_training') { 
		def vBuild = getVersion() //getVersion()
		sh("docker build -t 172.192.10.30:5000/task4:${vBuild} --build-arg vTask=${vBuild} .")
		}   
	stage 'Run task4 registry'
	    dir('devops_training') {
	    def vBuild = getVersion()
	    sh ("docker run -d -p 5000:5000 --restart=always --name task4 registry registry:2")
	    }
	stage 'Push to registry'
        dir('devops_training') {
        def vBuild = getVersion()	
        sh ("docker push 172.192.10.30:5000/task4:${vBuild}")
        }
	}
node ('tomcat1') {
	stage 'Run registry from another machine' 
	    dir('devops_training')  {
	    def vBuild = getVersion()
		sh ("docker run -d -p 8080:8080 --restart=always --name task4 172.192.10.30:5000/task4:${vBuild}")
    }
	stage 'Pull Task4' {
	    def vBuild = getVersion()
		sh 'docker pull 172.192.10.30:5000/task4:$vBuild'
	}
}
node ('master') {
	stage 'Check the version'
	dir('devops_training')	{
	def vBuild = getVersion() 
	def tomcat_war=sh returnStdout: true, script: "curl -s http://172.192.10.31:8080/task3/ | sed 's/<[^>]*>//g'"
	def gradle_war=sh returnStdout: true, script: "cat ./gradle.properties"
		if (tomcat_war.trim() == gradle_war.trim())
				{ echo '---------Tomcat1 is good----------'
            }
			else { echo '------------Tomcat1 is bad-----------'
            }
	}
}
node ("tomcat1") {
    stage 'Stop and remove task4'
		sh 'docker stop task4'
		sh 'docker rm task4'
}