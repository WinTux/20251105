pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git branch: 'master', url: 'https://github.com/WinTux/20251105.git', credentialsId: 'github-token'
      }
    }
    stage('Terraform Apply') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding', credencialsId: 'aws-credentials'
        ]]) {
          sh '''
          terraform init
          terraform plan -out=tfplan
          terraform apply -auto-approve tfplan
          '''
        }
      }
    }
  }
}
