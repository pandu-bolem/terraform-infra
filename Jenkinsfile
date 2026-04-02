pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Terraform action')
    }
    environment {
        TF_WORKING_DIR = "."
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/pandu-bolem/terraform-infra.git'
            }
        }
        stage('Terraform Init') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds',
                                                 usernameVariable: 'AWS_ACCESS_KEY_ID',
                                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir(TF_WORKING_DIR) {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Terraform Action') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds',
                                                 usernameVariable: 'AWS_ACCESS_KEY_ID',
                                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir(TF_WORKING_DIR) {
                        script {
                            if (params.ACTION == 'apply') {
                                sh 'terraform apply -auto-approve'
                            } else if (params.ACTION == 'destroy') {
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Terraform ${params.ACTION} completed!"
        }
    }
}
