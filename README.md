# Iris ML Application with Jenkins CI/CD

This project demonstrates a complete CI/CD pipeline using Jenkins for an Iris flower classification application with microservices architecture.

## Project Structure

```
demo_project/
├── dbapp/                  # Database microservice
│   ├── app.py             # Flask app for database operations
│   ├── Dockerfile         # Docker configuration
│   ├── .dockerignore      # Docker ignore file
│   └── requirements.txt   # Python dependencies
├── webapp/                # Web application microservice
│   ├── app.py            # Flask web application
│   ├── train_model.py    # ML model training script
│   ├── model.pkl         # Trained ML model (generated)
│   ├── Dockerfile        # Docker configuration
│   ├── .dockerignore     # Docker ignore file
│   ├── requirements.txt  # Python dependencies
│   └── templates/        # HTML templates
│       ├── index.html
│       └── display_records.html
├── test_sample.py        # Unit tests
├── docker-compose.yml    # Docker Compose configuration
├── Jenkinsfile          # Jenkins pipeline configuration
└── README.md            # This file
```

## Features

- **Microservices Architecture**: Separate services for web and database
- **Machine Learning**: Iris flower classification using Random Forest
- **Containerization**: Docker containers for each service
- **CI/CD Pipeline**: Automated build, test, and deployment with Jenkins
- **Database**: SQLite database for storing predictions
- **Health Checks**: Automated health monitoring for services

## Prerequisites

- Docker and Docker Compose
- Jenkins (for CI/CD)
- Python 3.11+
- Git

## Local Development

### 1. Train the Model

```bash
cd webapp
python train_model.py
```

### 2. Run Tests

```bash
pytest test_sample.py -v
```

### 3. Build and Run with Docker Compose

```bash
docker-compose up --build
```

Access the application:
- Web App: http://localhost:5000
- DB API: http://localhost:5001/records

## Jenkins CI/CD Pipeline

### Pipeline Stages

1. **Checkout**: Clone the repository
2. **Environment Setup**: Verify required tools
3. **Install Dependencies**: Install Python packages
4. **Train Model**: Generate ML model
5. **Run Tests**: Execute unit tests
6. **Build Docker Images**: Create container images
7. **Stop Existing Containers**: Clean up old containers
8. **Deploy**: Start new containers
9. **Health Check**: Verify services are running

### Setting Up Jenkins

1. **Install Jenkins**: Download from https://www.jenkins.io/

2. **Install Required Plugins**:
   - Docker Pipeline
   - Pipeline
   - Git
   - JUnit

3. **Create New Pipeline Job**:
   - New Item → Pipeline
   - Configure SCM (Git repository URL)
   - Set Pipeline script from SCM
   - Point to Jenkinsfile

4. **Configure Jenkins Agent**:
   - Ensure Docker is installed on Jenkins agent
   - Ensure Python is installed on Jenkins agent

5. **Run Pipeline**:
   - Click "Build Now"
   - Monitor the pipeline stages
   - Check console output for any issues

### Jenkins Environment Variables

The pipeline uses these environment variables:
- `DOCKER_COMPOSE_VERSION`: Docker Compose version
- `PROJECT_NAME`: Project identifier

## API Endpoints

### Web App (Port 5000)
- `GET /`: Main prediction form
- `POST /`: Submit prediction
- `GET /records`: View all predictions

### DB App (Port 5001)
- `GET /records`: Fetch all records (JSON)
- `POST /records`: Add new record (JSON)

## Testing

Run the test suite:

```bash
# Run all tests
pytest test_sample.py -v

# Run with coverage
pytest test_sample.py -v --cov=webapp
```

## Docker Commands

```bash
# Build images
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Remove volumes
docker-compose down -v
```

## Troubleshooting

### Services won't start
```bash
docker-compose logs
```

### Port already in use
```bash
# Change ports in docker-compose.yml
# Or stop conflicting services
```

### Model file missing
```bash
cd webapp
python train_model.py
```

### Tests failing
```bash
# Ensure all dependencies are installed
pip install -r webapp/requirements.txt
pip install pytest
```

## Production Considerations

1. **Database**: Replace SQLite with PostgreSQL/MySQL
2. **Security**: Add authentication and HTTPS
3. **Scaling**: Use Kubernetes for orchestration
4. **Monitoring**: Add Prometheus and Grafana
5. **Logging**: Implement centralized logging (ELK stack)
6. **Secrets**: Use environment variables for sensitive data

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and test
4. Submit a pull request

## License

MIT License

## Author

Created for demonstration of CI/CD pipeline with Jenkins, Docker, and Flask microservices.
