pipeline {
  environment{
    registry = "wisekingdavid/devops"
    registryCredential = 'dockerhub_id'  
    dockerImage = 'devops'
  }
  
    agent any

    tools {
      maven 'Maven-3.6.3'
    }

    stages {
      
      stage('Cloning git repo') {
        steps {
          git 'https://github.com/davochia/TodoAppWithLogin.git'
        }
      }

      stage('Build') {
        steps {
          script {
            dockerImage = docker.build + registry + ":1.0"
          }
        }
      }
      
      
      stage('deploy to dockerhub'){
        steps {
          script{
            docker.withRegistory('devops', registryCredential){
              dockerImage.push()
            }
          }
        }
      }
      
      stage('clean up'){
        steps {
          sh "docker rmi $registry:1.0"
        }
      }
    }
}
