node {
    def app

    stage('checkout'){
      checkout scm
    }

    // need to find a way to inject this config
    stage('build'){
      app = docker.build('docker.gillsoft.org/ubuntu-base', '--no-cache=true --force-rm=true .')
    }

    stage('publish') {
      docker.withRegistry('https://docker.gillsoft.org', 'docker-registry') {
         // app.push("${env.BUILD_TAG}")
        app.push('latest')
      }
    }
}
