node {
    def app

    stage('checkout'){
      // git url: 'https://gitlab.gillsoft.org/docker/ubuntu-base.git', credentialsId: 'gitlab'
      checkout scm
    }

    stage('build'){
      app = docker.build('docker.gillsoft.org/ubuntu-base', '--no-cache=true --force-rm=true')
    }

    stage('publish') {
      docker.withRegistry('https://docker.gillsoft.org', 'docker-registry') {
         // app.push("${env.BUILD_TAG}")
        app.push('latest')
      }
    }
}
