pipeline {
  environment{
    registory = "wisekingdavid/deveops"
    registryCredential = 'dockerhub_id'  
    dockerImage = 'deveops'
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
            dockerImage = docker.build + registry
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
    }
      
      stage('clean up'){
        steps {
          sh 'docker rmi $registry'
        }
      }
    }
}
