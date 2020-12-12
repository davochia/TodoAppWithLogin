pipeline {
  agent any

  tools {
    maven 'Maven-3.6.3'
  }

  stages {
    stage('Build') {
      steps {
        sh 'mvn package'
      }
    }
  }

  post {
    always {
      archive 'target/**/*.jar'
    }
  }
}
