pipeline {
  agent any
  environment {
    DOCKERHUB_REPO = "chandanakrishna27/mern-app"
    IMAGE_TAG = "${env.GIT_COMMIT[0..6]}"
    NODE_OPTIONS = "--max-old-space-size=256"
    // Add SonarQube later once we confirm pipeline runs
    // SONARQUBE_ENV = "sonar-local"
    // SONAR_SCANNER = "SonarQube Scanner"
  }
  tools {
    nodejs "node18"
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Install & Test') {
      steps {
        sh '''
          set -e
          SERVER_DIR=$( [ -d server ] && echo server || find . -maxdepth 2 -type d -name server | head -n1 )
          CLIENT_DIR=$( [ -d client ] && echo client || find . -maxdepth 2 -type d -name client | head -n1 )

          echo "SERVER_DIR=$SERVER_DIR"
          echo "CLIENT_DIR=$CLIENT_DIR"

          (cd "$SERVER_DIR" && npm ci && npm test --if-present)

          if [ -n "$CLIENT_DIR" ] && [ -f "$CLIENT_DIR/package.json" ]; then
            (cd "$CLIENT_DIR" && npm ci && npm run build --if-present)
          fi
        '''
      }
    }
    stage('Build & Push Image') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
            def img = docker.build("${DOCKERHUB_REPO}:${IMAGE_TAG}")
            img.push()
            sh "docker rmi ${DOCKERHUB_REPO}:${IMAGE_TAG} || true"
          }
        }
      }
    }
  }
}
