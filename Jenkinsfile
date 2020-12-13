pipeline {
     
     environment { 
     registry = "wisekingdavid/devops" 
     registryCredential = 'dockerhub_id' 
     dockerImage = '' 
     }
     
     agent any
     
     
     triggers {
        pollSCM '* * * * *'
    }
     
     tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven-3.6.3"
    }
     
     
     stages {
          
          stage('Build') {
            steps {
                // Get some code from a GitHub repository
               // git 'https://github.com/davochia/TodoAppWithLogin.git'//, branch: 'test-jenkins', credentialsId: 'GitHub' 

                // Run Maven on a Unix agent.
                sh "mvn clean package"

            }

            post {
               
                success {
                    //junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
            
        }
          
          stage('Building image'){
               steps { 
                script {                      
                     dockerImage = docker.build -t registry + ":$BUILD_NUMBER"
                }
            } 
          }
        
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                      dockerImage.push("$BUILD_NUMBER")
                         dockerImage.push('latest')
                    }
                } 
            }
        } 
          
          
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
                 sh "docker rmi $imagename:latest"
            }
        } 

 
        stage('Set Terraform path') {
            steps {
              script {
                def tfHome = tool name: 'Terraform'
                env.PATH = "${tfHome}:${env.PATH}"
               }
               sh 'terraform version'

              }
            }
          
          stage('Provision infrastructure') {
            steps {
                  withCredentials([azureServicePrincipal('azure-id')]) {
                      script{
                        sh  'terraform init'
                        sh  'terraform apply'
                        sh  'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'

                        }
                  }
                    // sh ‘terraform destroy -auto-approve’
              }

          }
        
    }
}
