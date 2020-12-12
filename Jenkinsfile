pipeline {
  environment{
    registry = "https://hub.docker.com/repository/docker/wisekingdavid/devops"
    registryCredential = 'dockerhub_id'  
    dockerImage = 'devops'
  }
  
  agent any

  tools {
    maven 'Maven-3.6.3'
  }
  
  stages {
    
    stage('clone git repo'){
      steps{
        git 'https://github.com/davochia/TodoAppWithLogin.git'
      }
    }

    stage('Build') {
      steps {
        script {
          //sh 'mvn package'
          dockerImage = docker.build + registry + ":$BUILD_NUMBER"
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
        sh "docker rmi $registry:BUILD_NUMBER"
      }
    }
  }
}
