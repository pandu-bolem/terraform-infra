pipeline {

    agent any

    parameters {

        choice(
            name: 'ENV',
            choices: ['dev', 'prod'],
            description: 'Select Environment'
        )

        choice(
            name: 'ACTION',
            choices: ['plan','apply','destroy'],
            description: 'Terraform Action'
        )

    }

    environment {
        TF_DIR = "environments/${params.ENV}"
    }

    stages {

        stage('Checkout Code') {

            steps {

                git branch: "${env.BRANCH_NAME}",
                url: 'https://github.com/pandu-bolem/terraform-infra.git'

            }

        }

        stage('Terraform Init') {

            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'aws-creds',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {

                    dir("${TF_DIR}") {

                        sh 'terraform init'

                    }

                }

            }

        }

        stage('Terraform Plan') {

            when {

                expression { params.ACTION == 'plan' }

            }

            steps {

                dir("${TF_DIR}") {

                    sh 'terraform plan -var-file=terraform.tfvars'

                }

            }

        }

        stage('Terraform Apply') {

            when {

                expression { params.ACTION == 'apply' }

            }

            steps {

                dir("${TF_DIR}") {

                    sh 'terraform apply -auto-approve -var-file=terraform.tfvars'

                }

            }

        }

        stage('Terraform Destroy') {

            when {

                expression { params.ACTION == 'destroy' }

            }

            steps {

                dir("${TF_DIR}") {

                    sh 'terraform destroy -auto-approve -var-file=terraform.tfvars'

                }

            }

        }

    }

}
