pipeline {
  agent any
  
  environment {
    PROJECT_ID = 'lbg-cohort-10'
    IMAGE_NAME = 'globbers'
    TAG = '1'
    GOOGLE_APPLICATION_CREDENTIALS = credentials('lbg-cohort-10')
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
        withCredentials([file(credentialsId: 'gcr-auth', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {

	  sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
          sh 'gcloud auth configure-docker'
	  sh "docker login -u _json_key -p '$(cat $GOOGLE_APPLICATION_CREDENTIALS)' https://gcr.io"
          sh "docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${TAG}"
        }
      }
    }
  }
}
