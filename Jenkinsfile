pipeline {
  agent any

  parameters {
    choice(name: 'CLOUD', choices: ['aws'], description: 'Select cloud provider')
    choice(name: 'RELEASE', choices: ['June_month'], description: 'Select release version')
    choice(name: 'REGION', choices: ['us-west'], description: 'Select region')
  }

  environment {
    TF_DIR = "terraform/${params.CLOUD}/ec2"
    SCRIPTS_DIR = "scripts"
  }

  

  stages {
    stage('Checkout') {
      steps {
        echo "Cloning Git repo..."
        checkout scm
      }
    }
    stage('Test Windows Shell') {
      steps {
        bat 'echo Hello from Windows!'
      }
    }

    stage('Generate master.tfvars') {
      steps {
        dir("${env.TF_DIR}") {
          echo "Generating master.tfvars using Python script..."
          bat """
            python ..\\..\\scripts\\generate_tfvars.py ^
              --cloud ${params.CLOUD} ^
              --region ${params.REGION} ^
              --release ${params.RELEASE} ^
              --output master.tfvars
          """
        }
      }
    }

    stage('Terraform Init & Plan') {
      steps {
        dir("${env.TF_DIR}") {
          echo "Running terraform init..."
          sh 'terraform init'

          echo "Running terraform plan..."
          sh 'terraform plan -var-file=master.tfvars -out=tfplan.out'
        }
      }
    }

    stage('Approve & Apply') {
      steps {
        input message: "Apply the Terraform plan?", ok: "Apply"
        dir("${env.TF_DIR}") {
          echo "Applying Terraform plan..."
          sh 'terraform apply tfplan.out'
        }
      }
    }
  }
}
