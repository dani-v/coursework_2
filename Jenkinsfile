pipeline {
    agent { 
	docker { 
		image "node:12-alpine" 
		args "-p 8000:800" 
	}
     }

    stages {
        stage("SonarQube") {
            environment {
                scanner = tool 'SonarQubeScanner'
            }
            
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh "${scanner}/bin/sonar-scanner"
                }

                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    def app
                    app = docker.build("dani-v/coursework_2")
                }
            }
        }


        stage("Push Docker Image") {
            steps {
                script {
                    docker.withRegistry("https://registry.hub.docker.com", "docker_credentials") {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }

        
    }
}