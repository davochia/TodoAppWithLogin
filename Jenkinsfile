pipeline{

    agent any
  
    stages {
  
        stage("build"){
            steps{
                echo 'Building application'
      
            }
        }
        
        stage("test"){
            steps{
                echo 'Testing application'
            }
        }
        
        stage("deploy"){
            steps{
                'Deploying application'
            }
        }
        
        stage("cleanup"){
            steps{
                'Clean up application'
            }
        }
    }

}
