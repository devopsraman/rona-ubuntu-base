node {
    def app

    stage('checkout'){
      checkout scm
    }

    // need to find a way to inject this config
    stage('build'){
      app = docker.build("docker.gillsoft.org/${JOB_BASE_NAME}:18.04", "--compress --no-cache=true --force-rm=true .")
    }

    stage('publish') {
      docker.withRegistry('https://docker.gillsoft.org', 'docker-registry') {
        app.push()
      }
    }
}
