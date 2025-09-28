#!groovy
node {
  def DOCKERHUB_REPO = "chandanakrishna27/mern-app"

  stage('Checkout') {
    checkout scm
  }

  def IMAGE_TAG = sh(returnStdout: true, script: 'git rev-parse --short=7 HEAD').trim()
  def nodeHome = tool name: 'node18', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'

  withEnv(["PATH+NODE=${nodeHome}/bin", "NODE_OPTIONS=--max-old-space-size=256"]) {
    stage('Install & Build') {
      sh '''set -e
# Detect folders
BACKEND_DIR=$( [ -d backend ] && echo backend || find . -maxdepth 2 -type d -name backend | head -n1 )
CLIENT_DIR=$(  [ -d client  ] && echo client  || find . -maxdepth 2 -type d -name client  | head -n1 )

echo "BACKEND_DIR=$BACKEND_DIR"
echo "CLIENT_DIR=$CLIENT_DIR"

if [ -z "$BACKEND_DIR" ] || [ ! -f "$BACKEND_DIR/package.json" ]; then
  echo "ERROR: Could not find backend/package.json"
  exit 1
fi

# Backend deps (ci if lockfile exists, else install)
if [ -f "$BACKEND_DIR/package-lock.json" ] || [ -f "$BACKEND_DIR/npm-shrinkwrap.json" ]; then
  (cd "$BACKEND_DIR" && npm ci)
else
  (cd "$BACKEND_DIR" && npm install)
fi

# Client deps + build (if present)
if [ -n "$CLIENT_DIR" ] && [ -f "$CLIENT_DIR/package.json" ]; then
  if [ -f "$CLIENT_DIR/package-lock.json" ] || [ -f "$CLIENT_DIR/npm-shrinkwrap.json" ]; then
    (cd "$CLIENT_DIR" && npm ci)
  else
    (cd "$CLIENT_DIR" && npm install)
  fi
  (cd "$CLIENT_DIR" && npm run build --if-present)
fi
'''
    }

    // Re-enable Sonar later once first green run completes
    // withSonarQubeEnv('sonar-local') { ... }

    stage('Build & Push Image') {
      sh "docker --version"
      docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
        def img = docker.build("${DOCKERHUB_REPO}:${IMAGE_TAG}")
        img.push()
        sh "docker rmi ${DOCKERHUB_REPO}:${IMAGE_TAG} || true"
      }
    }
  }
}
