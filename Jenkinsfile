pipeline {
  agent any
  stages {
    stage('Lint Dockerfile') {
      agent {
        docker {
          image 'hadolint/hadolint:latest-debian'
        }
      }
      steps {
        sh 'hadolint Dockerfile'
      }
    }
    stage('Lint HTML') {
      steps {
        sh 'tidy -q -e templates/index.html'
      }
    }
    stage('Build Docker') {
      steps {
        sh 'docker build --build-arg APP_PORT=5000 --tag=shubhi19/k8-flask-api .'
      }
    }
    stage('Login to dockerhub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-pwd', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh "docker build -t shubhi19/k8-flask-api ."
          sh "docker push shubhi19/k8-flask-api"
        }
      }
    }
    stage('Deploy Kubernetes') {
      steps {
        sh 'kubectl apply -f ./kubernetes'
      }
    }
  }
}
