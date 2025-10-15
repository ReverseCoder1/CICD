#!/bin/bash
# Setup script for Iris ML Application with Jenkins CI/CD

echo "============================================"
echo "Iris ML Application - Setup Script"
echo "============================================"
echo ""

# Check Python installation
echo "[1/6] Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed"
    echo "Please install Python 3.11 or higher"
    exit 1
fi
python3 --version
echo ""

# Check Docker installation
echo "[2/6] Checking Docker installation..."
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed"
    echo "Please install Docker from https://www.docker.com/"
    exit 1
fi
docker --version
echo ""

# Check Docker Compose
echo "[3/6] Checking Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    if ! docker compose version &> /dev/null; then
        echo "ERROR: Docker Compose is not available"
        exit 1
    fi
fi
docker-compose --version 2>/dev/null || docker compose version
echo ""

# Install Python dependencies
echo "[4/6] Installing Python dependencies..."
python3 -m pip install --upgrade pip
pip install pytest numpy scikit-learn
echo ""

# Train the ML model
echo "[5/6] Training the ML model..."
cd webapp
python3 train_model.py
cd ..
echo ""

# Build and start containers
echo "[6/6] Building and starting Docker containers..."
docker-compose build
docker-compose up -d
echo ""

# Wait for services to start
echo "Waiting for services to start..."
sleep 10

# Check if services are running
echo "Checking service status..."
docker-compose ps
echo ""

echo "============================================"
echo "Setup Complete!"
echo "============================================"
echo ""
echo "Application URLs:"
echo "  Web App:  http://localhost:5000"
echo "  DB API:   http://localhost:5001/records"
echo ""
echo "To stop the application:"
echo "  docker-compose down"
echo ""
echo "To view logs:"
echo "  docker-compose logs -f"
echo ""
echo "To run tests:"
echo "  pytest test_sample.py -v"
echo ""
