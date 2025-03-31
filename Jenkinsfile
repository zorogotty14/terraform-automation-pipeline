pipeline {
  agent any

  parameters {
    choice(name: 'CLOUD', choices: ['aws'], description: 'Select cloud provider')
    choice(name: 'RELEASE', choices: ['June_month'], description: 'Select release version')
    choice(name: 'REGION', choices: ['us-west'], description: 'Select region')
  }

  environment {
    TF_DIR = "terraform\\${params.CLOUD}\\ec2"
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
        bat 'echo Hello from Windows shell!'
      }
    }

    stage('Generate master.tfvars') {
      steps {
        dir("${env.TF_DIR}") {
          echo "Checking for existing master.tfvars..."
          bat '''
            if exist master.tfvars (
              copy master.tfvars master.tfvars.old
            )
          '''

          echo "Generating new master.tfvars..."
          bat """
            python ..\\..\\..\\scripts\\generate_tfvars.py ^
              --cloud ${params.CLOUD} ^
              --region ${params.REGION} ^
              --release ${params.RELEASE} ^
              --output master.tfvars
          """

          echo "Contents of new master.tfvars:"
          bat 'type master.tfvars'

          echo "Changes compared to previous version:"
          bat '''
            if exist master.tfvars.old (
              fc master.tfvars.old master.tfvars
            ) else (
              echo No previous version of master.tfvars found.
            )
          '''
        }
      }
    }


    stage('Terraform Init & Plan') {
      steps {
        dir("${env.TF_DIR}") {
          echo "Running terraform init..."
          bat 'terraform init'

          echo "Running terraform plan..."
          bat 'terraform plan -var-file=master.tfvars -out=tfplan.out > plan.log'

          echo "Terraform Plan Output:"
          bat 'type plan.log'
        }
      }
    }

    stage('Approve & Apply') {
      steps {
        input message: "Apply the Terraform plan?", ok: "Apply"
        dir("${env.TF_DIR}") {
          echo "Applying Terraform plan..."
          bat 'terraform apply tfplan.out'
        }
      }
    }
  }
}
