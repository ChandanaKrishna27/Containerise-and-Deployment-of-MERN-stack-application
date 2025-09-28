#!groovy
node {
  // --- Config you can tweak ---
  def DOCKERHUB_REPO = "chandanakrishna27/mern-app"

  stage('Checkout') {
    checkout scm
  }

  // Derive a short image tag from the commit
  def IMAGE_TAG = sh(returnStdout: true, script: 'git rev-parse --short=7 HEAD').trim()

  // Add Node.js 18 to PATH (requires a NodeJS tool named "node18" in Manage Jenkins → Tools)
  def nodeHome = tool name: 'node18', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
  withEnv(["PATH+NODE=${nodeHome}/bin", "NODE_OPTIONS=--max-old-space-size=256"]) {

    stage('Install & Test') {
      sh '''set -e
SERVER_DIR=$( [ -d server ] && echo server || find . -maxdepth 2 -type d -name server | head -n1 )
CLIENT_DIR=$( [ -d client ] && echo client || find . -maxdepth 2 -type d -name client | head -n1 )

echo "SERVER_DIR=$SERVER_DIR"
echo "CLIENT_DIR=$CLIENT_DIR"

# Server deps + tests
(cd "$SERVER_DIR" && npm ci && npm test --if-present)

# Client deps + build (if present)
if [ -n "$CLIENT_DIR" ] && [ -f "$CLIENT_DIR/package.json" ]; then
  (cd "$CLIENT_DIR" && npm ci && npm run build --if-present)
fi
'''
    }

    // Re-add Sonar later once first green run completes
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
