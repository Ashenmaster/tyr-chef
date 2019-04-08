pipeline {
  agent {
    dockerfile {
      filename '/cookbooks/docker-setup/Dockerfile'
    }

  }
  stages {
    stage('') {
      steps {
        dir(path: '/cookbooks/docker-setup/') {
          chef_cookbook_functional()
        }

      }
    }
  }
}