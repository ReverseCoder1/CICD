pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ReverseCoder1/CICD.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker-compose build'
            }
        }

        stage('Run Containers') {
            steps {
                sh 'docker-compose up -d'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'echo Running tests...'
                // Replace with actual test commands like:
                // sh 'pytest test_sample.py -v'
            }
        }

        stage('Cleanup') {
            steps {
                sh 'docker-compose down'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}


