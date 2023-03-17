pipeline {
  agent any
  
  environment {
    PROJECT_ID = 'lbg-cohort-10'
    IMAGE_NAME = 'globbers'
    TAG = '1'
    GOOGLE_APPLICATION_CREDENTIALS = credentials('json_secret_file')
  }
  
  stages {
    stage('Build Docker image') {
      steps {
        sh "docker build -t ${IMAGE_NAME}:${TAG} ."
      }
    }
    
    stage('Tag Docker image') {
      steps {
        sh "docker tag ${IMAGE_NAME}:${TAG} gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${TAG}"
      }
    }
    
    stage('Push Docker image to GCR') {
      steps {
        withCredentials([file(credentialsId: 'json_secret_file', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
		
	  sh 'docker login -u _json_key -p "$(cat $GOOGLE_APPLICATION_CREDENTIALS)" https://gcr.io'
	  sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
          sh 'gcloud auth configure-docker'
          sh "docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${TAG}"
        }
      }
    }

    stage('Deploy Kuberctl') {
      steps {
        withCredentials([file(credentialsId: 'json_secret_file', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {

        sh 'kubectl apply -f globbers.yml --token "$GOOGLE_APPLICATION_CREDENTIALS"'
        sh 'kubectl get pods'
        sh 'kubectl get services'
      }
      }
    }
  

    stage('Congratulations Globbers, much success') {
      steps {
        echo "ThemBaba??? more like WhoBaba"
        echo "Jon Street Boys??? more like NoSYNC"
      }
    }
  }
}
