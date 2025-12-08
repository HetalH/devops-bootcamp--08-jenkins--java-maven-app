pipeline{
    agent any
    stages{
        stage("increment version") {
                     steps {
                         script {
                            echo 'incrementing app version....'
                            sh 'mvn build-helper:parse-version versions:set -DnewVersion=${parsedVersion.majorVersion}.${parsedVersion.minorVersion}.${parsedVersion.nextIncrementalVersion} versions:commit'
                         }
                     }
                 }
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
                     echo "Deploying the application..."
                 }
             }
         }
    }
}