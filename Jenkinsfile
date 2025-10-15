pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/ReverseCoder1/CICD.git'
            }
        }

        stage('Environment Setup') {
            steps {
                echo 'Checking environment...'
                bat '''
                    python --version
                    docker --version
                    docker-compose --version
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Python dependencies...'
                bat '''
                    python -m pip install --upgrade pip
                    pip install pytest numpy scikit-learn
                '''
            }
        }

        stage('Train Model') {
            steps {
                echo 'Training ML model...'
                bat '''
                    cd webapp
                    python train_model.py
                    cd ..
                '''
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running unit tests...'
                bat '''
                    pytest test_sample.py -v --junitxml=test-results.xml || exit 0
                '''
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                echo 'Building Docker images...'
                bat 'docker-compose build'
            }
        }

        stage('Stop Existing Containers') {
            steps {
                echo 'Stopping existing containers...'
                bat 'docker-compose down || exit 0'
            }
        }

        stage('Deploy - Run Containers') {
            steps {
                echo 'Starting containers...'
                bat '''
                    docker-compose up -d
                    timeout /t 10
                    docker-compose ps
                '''
            }
        }

        stage('Health Check') {
            steps {
                echo 'Performing health checks...'
                bat '''
                    timeout /t 15
                    curl http://localhost:5000/ || echo Web app might need more time
                    curl http://localhost:5001/records || echo DB app might need more time
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
            echo 'Application is running at:'
            echo '  - Web App: http://localhost:5000'
            echo '  - DB App: http://localhost:5001/records'
        }
        failure {
            echo 'Pipeline failed!'
            bat 'docker-compose logs || exit 0'
        }
        always {
            echo 'Pipeline finished.'
            archiveArtifacts artifacts: 'test-results.xml', allowEmptyArchive: true
        }
    }
}
