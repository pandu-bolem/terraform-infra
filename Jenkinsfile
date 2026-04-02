pipeline {
    agent any

    // Optional global environment variables
    environment {
        TF_WORKING_DIR = "./terraform" // path to your Terraform code
    }

    stages {

        stage('Checkout Code') {
            steps {
                // Pull code from GitHub
                git branch: 'main',
                    url: 'https://github.com/pandu-bolem/terraform-infra.git'
            }
        }

        stage('Terraform Init') {
            steps {
                // Use Jenkins AWS credential safely
                withCredentials([usernamePassword(
                    credentialsId: 'aws-creds', 
                    usernameVariable: 'AWS_ACCESS_KEY_ID', 
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    
                    sh """
                        cd $TF_WORKING_DIR
                        terraform init
                    """
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-creds', 
                    usernameVariable: 'AWS_ACCESS_KEY_ID', 
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    
                    sh """
                        cd $TF_WORKING_DIR
                        terraform plan -out=tfplan.out
                    """
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Approve Terraform Apply?"  // Manual approval
                withCredentials([usernamePassword(
                    credentialsId: 'aws-creds', 
                    usernameVariable: 'AWS_ACCESS_KEY_ID', 
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    
                    sh """
                        cd $TF_WORKING_DIR
                        terraform apply -auto-approve tfplan.out
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Terraform deployed successfully!"
        }
        failure {
            echo "Build failed!"
        }
    }
}
