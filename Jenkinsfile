#!/user/bin/env groovy
//@Library('jenkins-shared-library')
library identifier: "jenkins-shared-library@master", retriever: modernSCM(
[$class: 'GitSCMSource',
remote: 'https://github.com/HetalH/devops-bootcamp--08-jenkins--jenkins-shared-library.git',
credentialsId: 'github-credentials'])
def gv

pipeline{
    agent any
     tools {
            maven 'maven-3.9'
        }
    stages{
         stage("init"){
                    steps {
                        script {
                            gv = load "script.groovy"
                        }
                    }
                }
        stage("build jar"){
                    steps {
                        script {
                          buildJar()
                        }
                    }
                }
        stage("build and push image"){
                    steps {
                        script {
                              buildImage 'hetallearn/demo-app:jma-3.0'
                              dockerLogin()
                              dockerPush 'hetallearn/demo-app:jma-3.0'
                            }
                        }
                    }

        stage("deploy"){
                steps {
                    script {
                        gv.deployApp()
                    }
                }
            }
    }
}