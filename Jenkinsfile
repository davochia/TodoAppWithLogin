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

    stage('clean up'){
      steps {
        sh "docker rmi $registry"
      }
    }
  }
}
