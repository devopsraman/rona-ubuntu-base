node {
    def app

    stage('checkout'){
      checkout scm
    }

    // need to find a way to inject this config
    stage('build'){
      // branch name gives job name which in turn gives tag
      app = docker.build("docker.gillsoft.org/ubuntu-base:${JOB_BASE_NAME}", "--compress --no-cache=true --force-rm=true .")
    }

    stage('publish') {
      docker.withRegistry('https://docker.gillsoft.org', 'docker-registry') {
        app.push()
      }
    }
}
