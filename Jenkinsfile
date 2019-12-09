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

        
    }
}