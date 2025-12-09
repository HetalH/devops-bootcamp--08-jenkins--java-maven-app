pipeline{
    agent any
    stages{
        stage("test"){
            steps {
                script {
                    echo "Testing the application..."
                    echo "Executing pipeline for branch $BRANCH_NAME"
                }
            }
        }
        stage("build"){
            when {
                expression {
                    BRANCH_NAME == "master"
                }
            }
            steps {
                script {
                    echo "Building the application..."
                }
            }
        }
         stage("deploy"){
            when {
                expression {
                    BRANCH_NAME == "master"
                }
            }
             steps {
                 script {
                    def dockerCmd = 'docker run -p 3080:3080 -d hetallearn/web-app:1.0'
                     sshagent(['ec2-server-key']) {
                         sh "ssh -o StrictHostKeyChecking=no ec2-user@3.238.29.241 ${dockerCmd}"
                     }
                 }
             }
         }
    }
}