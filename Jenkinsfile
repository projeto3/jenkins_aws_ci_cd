//Declarative Pipeline

pipeline {

    agent any

    stages {
       //  stage('Dependencias') {
//
         //   steps {
   
       //     dir('/') {
       //             sh "sudo rm -r *"
        //            }
                
       //         echo 'Destruindo build Anterior..'

       //     }

    //    }
        stage('Build') {

            steps {
   
                git url: 'https://github.com/projeto3/jenkins_aws_ci_cd.git'
                
                echo 'Building..'

            }

        }
         stage('Config') {

            steps {
                dir('terraform/') {
                    sh 'cp /var/lib/jenkins/workspace/provider.tf .'
                sh "sudo terraform init"
                }
                echo 'Configuring..'

            }


        }
        stage('Criando Instancia') {
                        steps {
                    dir('terraform/') {
                    sh "sudo terraform apply -auto-approve"
                    }
                    echo 'Criando Instancia..'

            }
        
        }

        stage('Testes') {

            steps {
                    script {
                        // capture the approval details in approvalMap.
                        approvalMap = input id: 'test', message: 'Aplicação Buildada com Sucesso', ok: 'Processar',
                        parameters: [choice(choices: 'Sim,Testes Realizados pode destruir\nAplicar em Procução', description: 'Select Ambiente', name: 'Build'), string(defaultValue: '', description: '', name: 'Descrição')],  submitterParameter: 'APPROVER'
                    
                }
                

            }

        }

        stage('Deploy') {

            steps {

                echo 'Deploying....'

            }

        }
                stage('Destroy') {

            steps {
                dir('terraform/') {
                sh "sudo terraform destroy -force"
                }
                echo 'Apagando repo...

            }

        }

    }

}
