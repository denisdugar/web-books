properties([pipelineTriggers([githubPush()])])

node {git url: 'https://denisdugar:254693178521Dd@github.com/denisdugar/web-books', branch: 'main'}

pipeline{
    agent any
    tools {
        go "go1.16.4"
    }
    environment{
        imageName = "webbooks"
        registryCredentials = "nexus"
        registry = "18.117.130.116:8085"
        dockerImage = ''
        GO111MODULE = 'on'
    }
    stages{
        
        stage('checkout'){
            
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://denisdugar:254693178521Dd@github.com/denisdugar/web-books']]])
            }
        }
        
        stage('build image'){
            
            steps{
                script{
                    dockerImage = docker.build imageName
                }
            }
        }
        
        stage('upload to nexus'){
            
            steps{
                
                script{
                    docker.withRegistry( 'http://'+registry, registryCredentials ) {
                    dockerImage.push('latest')
                    }
                }
            }
        }
        
        stage('SonarTests') {
            steps{
                sh 'go test ./... -coverprofile=coverage.out'
                sh """/opt/sonar-scanner/sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner \
                    -Dsonar.projectKey=MyProject \
                    -Dsonar.go.coverage.reportPaths=coverage.out \
                    -Dsonar.coverage.dtdVerification=false \
                    -Dsonar.test.reportPath=test.xml \
                    -Dsonar.sources=./ \
                    -Dsonar.tests=./ \
                    -Dsonar.test.inclusions=**/**_test.go \
                    -Dsonar.sources.inclusions=**/**.go \
                    -Dsonar.host.url=http://18.117.130.116:9000 \
                    -Dsonar.login=152586db3d5196613a9564c034e24465864bc549"""
            }
        }
}
post{
	always{
		echo 'Hello!'
		emailext body: 'Test message',
		subject: 'Test subject',
		to: 'testdenisdugar@gmail.com'
		}
	}
}

