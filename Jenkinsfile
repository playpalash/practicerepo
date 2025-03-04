pipeline {
    agent any
    environment {
         DOCKER_REGISTRY = 'playpalash/application'
         DOCKER_REGISTRY_CREDENTIALS_ID = 'DockerHub'
    }
    stages {
        stage('Checkout') {
           steps {
               git url: 'https://github.com/playpalash/practicerepo.git', credentialsId: 'GitHub'
           }
        }

        stage('List Workspace') {
           steps {
               sh 'ls -la'
           }
        }

        stage('Building Docker Image') {
           steps {
               script {
                   dockerImage = docker.build("${DOCKER_REGISTRY}:${env.BUILD_NUMBER}")
               }
           }
        }
        stage('Pushing Image to registry') {
           steps {
               script {
                   docker.withRegistry('', "${DOCKER_REGISTRY_CREDENTIALS_ID}") {
                        dockerImage.push()
                   }
               }
           }
        }
        stage('Deploy to K8s') {
           steps {
               withCredentials([credentialsId: 'KubernetesConfig']) {
                   sh '''
                      kubectl set image deployment/hello-world-deployment
                   '''
               }
           }
        }
   }
   post {
      success {
          echo 'Deployment Successful !!!'
      }
      failure {
          echo 'Deployment Failed.'
      }
   }
}
