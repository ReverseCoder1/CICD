@echo off
REM Setup script for Iris ML Application with Jenkins CI/CD

echo ============================================
echo Iris ML Application - Setup Script
echo ============================================
echo.

REM Check Python installation
echo [1/6] Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.11 or higher from https://www.python.org/
    pause
    exit /b 1
)
python --version
echo.

REM Check Docker installation
echo [2/6] Checking Docker installation...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed or not in PATH
    echo Please install Docker Desktop from https://www.docker.com/
    pause
    exit /b 1
)
docker --version
echo.

REM Check Docker Compose
echo [3/6] Checking Docker Compose...
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: docker-compose not found, trying 'docker compose'...
    docker compose version >nul 2>&1
    if %errorlevel% neq 0 (
        echo ERROR: Docker Compose is not available
        pause
        exit /b 1
    )
)
docker-compose --version 2>nul || docker compose version
echo.

REM Install Python dependencies
echo [4/6] Installing Python dependencies...
python -m pip install --upgrade pip
pip install pytest numpy scikit-learn
echo.

REM Train the ML model
echo [5/6] Training the ML model...
cd webapp
python train_model.py
cd ..
echo.

REM Build and start containers
echo [6/6] Building and starting Docker containers...
docker-compose build
docker-compose up -d
echo.

REM Wait for services to start
echo Waiting for services to start...
timeout /t 10 /nobreak >nul

REM Check if services are running
echo Checking service status...
docker-compose ps
echo.

echo ============================================
echo Setup Complete!
echo ============================================
echo.
echo Application URLs:
echo   Web App:  http://localhost:5000
echo   DB API:   http://localhost:5001/records
echo.
echo To stop the application:
echo   docker-compose down
echo.
echo To view logs:
echo   docker-compose logs -f
echo.
echo To run tests:
echo   pytest test_sample.py -v
echo.
pause
