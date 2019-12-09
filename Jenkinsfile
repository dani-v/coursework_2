pipeline {
    
   agent any

    stages {
        stage('Checkout SCM'){
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/daniela_branch']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/dani-v/coursework_2.git']]])
            }
        }
	
        stage('SonarQube Code Analysis') {
            environment {
                scanner = tool 'SonarQube'
            }
            
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "${scanner}/bin/sonar-scanner -D sonar.login=admin -D sonar.password=admin"
                }
            }
        }
        
        stage('Quality Gate'){
            steps {
               timeout(time: 15, unit: 'MINUTES') {
               waitForQualityGate abortPipeline: true
               }
            }
        }
        
        stage('Build & Push Docker Image') {
            steps {
                script {
                    def app = docker.build("danielavasileva/coursework_2")
                    docker.withRegistry("https://registry.hub.docker.com", "docker_credentials") {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                }
            }
          }
        }
    }
}