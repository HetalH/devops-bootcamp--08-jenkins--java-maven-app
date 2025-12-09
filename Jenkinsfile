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
     environment {
        IMAGE_NAME = 'hetallearn/demo-app:java-maven-2.0'
     }
    stages{
         stage("init"){
                    steps {
                        script {
                            gv = load "script.groovy"
                        }
                    }
                }
        
        stage("build app"){
                    steps {
                        script {
                          echo 'building application jar...'
                          buildJar()
                        }
                    }
                }
        stage("build and push image"){
                    steps {
                        script {
                              buildImage(env.IMAGE_NAME)
                              dockerLogin()
                              dockerPush(env.IMAGE_NAME)
                            }
                        }
                    }

        stage("deploy"){
                steps {
                    script {
                        gv.deployApp()
                        def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME} param2"
                        def ec2Instance = "ec2-user@3.238.29.241"
                        sshagent(['ec2-server-key']) {
                            sh "scp server-cmds.sh ${ec2Instance}:/home/ec2-user"
                            sh "scp docker-compose.yaml  ${ec2Instance}:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no  ${ec2Instance} ${shellCmd}"
                        }
                    }
                }
            }

    }
}
