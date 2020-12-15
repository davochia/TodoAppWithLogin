pipeline {
    
       environment { 

        registry = 'wisekingdavid/devops' 

        registryCredential = 'dockerhub_id' 

        dockerImage = '' 

    }

    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven-3.6.3"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git ([url: 'https://github.com/davochia/TodoAppWithLogin.git', branch: 'test-jenkins', credentialsId: 'github'])
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    //junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
            
        }
        
        stage('Cloning our Git') { 

            steps { 

                git ([url: 'https://github.com/davochia/TodoAppWithLogin.git', branch: 'test-jenkins', credentialsId: 'github'])

            }
        } 
        stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                      dockerImage.push() 

                    }

                } 

            }

        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
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
              //withCredentials([azureServicePrincipal('1fba7590-0c5e-4cd4-a8a9-733e30590c66')]) {
                  script{
                    //sh  'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                    sh  'terraform init'
                    sh  'terraform apply -input=false -auto-approve'
                      
                    }
              }
                // sh ‘terraform destroy -auto-approve’
          //}

        }
        
    }
}

