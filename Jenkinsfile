pipeline{
    agent any
    stages{
        stage("test"){
            steps {
                script {
                    echo "Testing the application..."
                    echo "Testin123"
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
                     echo "Deploying the application..."
                 }
             }
         }
    }
}
