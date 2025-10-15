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
                bat 'docker-compose build'
            }
        }

        stage('Run Containers') {
            steps {
                bat 'docker-compose up -d'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'echo Running tests...'
                // Replace with actual test commands like:
                // bat 'pytest'
            }
        }

        stage('Cleanup') {
            steps {
                bat 'docker-compose down'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}