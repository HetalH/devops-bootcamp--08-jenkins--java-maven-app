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
        
         stage("increment the version"){
                    steps {
                        script {
                            echo "increment pom version"
                            sh 'mvn build-helper:parse-version versions:set -DnewVersion=\\${parsedVersion.majorVersion}.\\${parsedVersion.minorVersion}.\\${parsedVersion.nextIncrementalVersion} versions:commit'
                            echo "fetch version"
                            def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                            def version = matcher[0][1]
                            echo "$version - new version number"
                            env.IMAGE_NAME = "$version-$BUILD_NUMBER"
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
                              buildImage "hetallearn/demo-app:jma-${IMAGE_NAME}"
                              dockerLogin()
                              dockerPush "hetallearn/demo-app:jma-${IMAGE_NAME}"
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
        stage("commit version update"){
                 steps {
                     script {
                         withCredentials([string(credentialsId: 'github-pat', variable: 'GITHUB_TOKEN')]) {
                                    sh 'git config user.email "jenkins@example.com"'
                                    sh 'git config user.name "jenkins"'
                                    sh 'git status'
                                    sh 'git branch'
                                    sh 'git config --list'
                                    sh 'git remote set-url origin https://${GITHUB_TOKEN}@github.com/HetalH/devops-bootcamp--08-jenkins--java-maven-app.git'
                                    sh 'git add .'
                                    sh  'git commit -m "ci: version bump"'
                                    sh 'git push https://HetalH:${GITHUB_TOKEN}@github.com/HetalH/devops-bootcamp--08-jenkins--java-maven-app.git HEAD:jenkins-shared-lib'
                                }
                     }
                 }
             }
    }
}
