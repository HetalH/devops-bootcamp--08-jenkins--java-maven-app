pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "157.245.99.195"
    }
    stages {
        stage("copy files to ansible server") {
          steps {
                script {
                    echo "copying all necessary files to ansible control node"
                    sshagent(['ansible-server-key']){
                        sh " scp -o StrictHostKeyChecking=no ansible/* root@${ANSIBLE_SERVER}:/root"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                            sh 'scp $keyfile root@${ANSIBLE_SERVER}:/root/ansible.pem'
                        }
                    }
                }
            }
        }
      stage ("execute ansible playbook") {
            steps {
              script {
                echo "calling ansible playbook to configure ec2 instances"
                sshagent(['ansible-server-key']){
                     sh '''
                          ssh -o StrictHostKeyChecking=no root@${ANSIBLE_SERVER} \
                          ansible-playbook my-playbook.yaml
                        '''
                }
              }
            }
          }

    }
}
