pipeline {
  agent any
  tools {
    terraform 'Terraform_1.13'
  }
  environment {
    APP_NAME = "ProySpring"
    JAR_PATH = "ProySpring/target/${APP_NAME}.jar"
    ANSIBLE_ROLE_PATH = "roles/springboot/files"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build y Tests'){
      steps {
        dir('ProySpring'){
          sh '''
          ./mvnw clean package -DskipTests=false
          mv target/ProySpring-*.jar target/ProySpring.jar
          '''
        }
      }
      post {
        success {
          echo "Compilación y pruebas exitosas [OK!]"
        }
        failure {
          error("Falló la compilación o las pruebas. Pipeline detenido :c")
        }
      }
    }
    stage('Copiando el JAR al rol de Ansible') {
      steps {
        sh '''
        cp ${JAR_PATH} ${ANSIBLE_ROLE_PATH}/ProySpring.jar
        ls -lh ${ANSIBLE_ROLE_PATH}
        '''
      }
    }
    stage('Ejecución de Terraform init, plan, Apply') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credencialsId: 'aws-credentials'],file(credencialsId: 'clasesdevops-pem', variable:'AWS_KEY_FILE')]) {
          sh '''
          terraform init
          terraform validate
          terraform plan -var="ruta_private_key=${AWS_KEY_FILE}" -out=tfplan
          terraform apply -auto-approve tfplan
          '''
        }
      }
    }
    stage('Deploy usando Ansible') {
      steps {
        sh '''
        ansible-playbook -i inventory main.yml
        '''
      }
    }
  }
  post {
    success {
      echo "Pipeline ejecutado correctamente [OK!]"
    }
    failure {
      error("Error en el Pipeline :c")
    }
  }

}
