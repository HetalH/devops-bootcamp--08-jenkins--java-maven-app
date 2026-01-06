pipeline {
    agent any
    stages {
        stage("copy files to ansible server") {
          steps {
                script {
                    echo "copying all necessary files to ansible control node"
                    sshagent(['ansible-server-key']){
                        sh " scp -o StrictHostKeyChecking=no ansible/* root@157.245.99.195:/root"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                            sh 'scp $keyfile root@157.245.99.195:/root/ansible.pem'
                        }
                    }
                }
            }
        }
      stage ("execute ansible playbook") {
            steps {
              script {
                echo "calling ansible playbook to configure ec2 instances"
                withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                   sshCommand remote: [
                                        name: 'ansible-server',
                                        host: '157.245.99.195',
                                        user: user,
                                        identityFile: keyfile,
                                        port: 22,
                                        allowAnyHosts: true
                                      ], command: "ls -l"
                }
              }
            }
          }

    }
}
