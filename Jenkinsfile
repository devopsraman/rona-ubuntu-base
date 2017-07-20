node {
    docker.withRegistry('https://docker.gillsoft.org', 'docker-registry') {

        stage 'checkout'

        git url: 'https://gitlab.gillsoft.org/docker/ubuntu-base.git', credentialsId: 'gitlab'

        sh 'git rev-parse HEAD > .git/commit-id'
        def commit_id = readFile('.git/commit-id').trim()
        println commit_id

        stage 'build'
        def app = docker.build 'docker.gillsoft.org/ubuntu-base'
        stage 'publish'

        // app.push("${env.BUILD_TAG}")
        app.push('latest')
    }
}
