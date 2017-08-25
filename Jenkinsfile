pipeline {
    agent { dockerfile true }

    stages {
        stage('Test') {
            steps {
                sh('./script/test')
            }
        }
    }
}
