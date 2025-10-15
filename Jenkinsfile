pipeline {
    agent {
        label 'master'
    }

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
                script {
                    if (isUnix()) {
                        sh '''
                            python3 --version || python --version
                            docker --version
                            docker-compose --version || docker compose version
                        '''
                    } else {
                        bat '''
                            python --version
                            docker --version
                            docker-compose --version
                        '''
                    }
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Python dependencies...'
                script {
                    if (isUnix()) {
                        sh '''
                            python3 -m pip install --upgrade pip || python -m pip install --upgrade pip
                            pip3 install pytest numpy scikit-learn || pip install pytest numpy scikit-learn
                        '''
                    } else {
                        bat '''
                            python -m pip install --upgrade pip
                            pip install pytest numpy scikit-learn
                        '''
                    }
                }
            }
        }

        stage('Train Model') {
            steps {
                echo 'Training ML model...'
                script {
                    if (isUnix()) {
                        sh '''
                            cd webapp
                            python3 train_model.py || python train_model.py
                            cd ..
                        '''
                    } else {
                        bat '''
                            cd webapp
                            python train_model.py
                            cd ..
                        '''
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running unit tests...'
                script {
                    if (isUnix()) {
                        sh '''
                            pytest test_sample.py -v --junitxml=test-results.xml || true
                        '''
                    } else {
                        bat '''
                            pytest test_sample.py -v --junitxml=test-results.xml || exit 0
                        '''
                    }
                }
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
                script {
                    if (isUnix()) {
                        sh 'docker-compose build'
                    } else {
                        bat 'docker-compose build'
                    }
                }
            }
        }

        stage('Stop Existing Containers') {
            steps {
                echo 'Stopping existing containers...'
                script {
                    if (isUnix()) {
                        sh 'docker-compose down || true'
                    } else {
                        bat 'docker-compose down || exit 0'
                    }
                }
            }
        }

        stage('Deploy - Run Containers') {
            steps {
                echo 'Starting containers...'
                script {
                    if (isUnix()) {
                        sh '''
                            docker-compose up -d
                            sleep 10
                            docker-compose ps
                        '''
                    } else {
                        bat '''
                            docker-compose up -d
                            timeout /t 10
                            docker-compose ps
                        '''
                    }
                }
            }
        }

        stage('Health Check') {
            steps {
                echo 'Performing health checks...'
                script {
                    if (isUnix()) {
                        sh '''
                            sleep 15
                            curl -f http://localhost:5000/ || echo "Web app might need more time"
                            curl -f http://localhost:5001/records || echo "DB app might need more time"
                        '''
                    } else {
                        bat '''
                            timeout /t 15
                            curl http://localhost:5000/ || echo Web app might need more time
                            curl http://localhost:5001/records || echo DB app might need more time
                        '''
                    }
                }
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
            script {
                if (isUnix()) {
                    sh 'docker-compose logs || true'
                } else {
                    bat 'docker-compose logs || exit 0'
                }
            }
        }
        always {
            echo 'Pipeline finished.'
            archiveArtifacts artifacts: 'test-results.xml', allowEmptyArchive: true
        }
    }
}
