#!/bin/bash

# League Management System - Local Development Setup Script
# This script automates the setup process for development environment

set -e

echo "=================================="
echo "🚀 League Management System Setup"
echo "=================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Check prerequisites
print_status "Checking prerequisites..."

if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed"
    exit 1
fi
print_success "Node.js v$(node --version) is installed"

if ! command -v flutter &> /dev/null; then
    print_warning "Flutter is not installed. Please install Flutter from https://flutter.dev"
else
    print_success "Flutter is installed"
fi

if ! command -v docker &> /dev/null; then
    print_warning "Docker is not installed. Will try to use local PostgreSQL"
else
    print_success "Docker is installed"
fi

echo ""

# Setup Backend
print_status "Setting up NestJS Backend..."

BACKEND_DIR="/home/abdo/Desktop/leage/nest-js"

if [ ! -d "$BACKEND_DIR" ]; then
    print_error "Backend directory not found: $BACKEND_DIR"
    exit 1
fi

cd "$BACKEND_DIR"

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    print_status "Installing backend dependencies..."
    npm install
    print_success "Backend dependencies installed"
else
    print_success "Backend dependencies already installed"
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    print_status "Creating .env file..."
    cat > .env << EOF
DATABASE_URL="postgresql://league_user:league_password@localhost:5432/league_db?schema=public"
JWT_SECRET="your_super_secret_jwt_key_change_this_in_production"
PORT=3000
NODE_ENV="development"
CORS_ORIGIN="http://localhost:3000,http://localhost:8080,http://127.0.0.1:3000"
EOF
    print_success ".env file created"
else
    print_success ".env file already exists"
fi

# Build the project
print_status "Building backend..."
npm run build
print_success "Backend built successfully"

echo ""

# Setup Database
print_status "Checking database..."

if command -v docker &> /dev/null && [ -f "docker-compose.yml" ]; then
    print_status "Checking if PostgreSQL is running..."
    
    if docker ps | grep -q postgres; then
        print_success "PostgreSQL is already running"
    else
        print_status "Starting PostgreSQL with Docker Compose..."
        docker-compose up -d
        sleep 5
        print_success "PostgreSQL started"
    fi
else
    print_warning "Docker not available or docker-compose.yml not found"
    print_warning "Please ensure PostgreSQL is running on localhost:5432"
fi

echo ""

# Run Prisma migrations
print_status "Running Prisma migrations..."
npx prisma migrate deploy
print_success "Migrations completed"

echo ""

# Setup Frontend (optional)
read -p "Setup Flutter frontend? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    FRONTEND_DIR="/home/abdo/Desktop/leage/league_app"
    
    if [ ! -d "$FRONTEND_DIR" ]; then
        print_error "Frontend directory not found: $FRONTEND_DIR"
    else
        cd "$FRONTEND_DIR"
        
        print_status "Installing Flutter dependencies..."
        flutter pub get
        print_success "Flutter dependencies installed"
    fi
fi

echo ""
echo "=================================="
echo -e "${GREEN}✓ Setup completed!${NC}"
echo "=================================="
echo ""
echo "📝 Next steps:"
echo ""
echo "1️⃣  Start the backend (in new terminal):"
echo -e "   ${BLUE}cd $BACKEND_DIR${NC}"
echo -e "   ${BLUE}npm run start:dev${NC}"
echo ""
echo "2️⃣  Backend will be available at:"
echo -e "   🌐 API: ${BLUE}http://localhost:3000/api${NC}"
echo -e "   📚 Docs: ${BLUE}http://localhost:3000/api/docs${NC}"
echo ""
echo "3️⃣  Start the mobile app (in new terminal):"
echo -e "   ${BLUE}cd /home/abdo/Desktop/leage/league_app${NC}"
echo -e "   ${BLUE}flutter run${NC}"
echo ""
echo "📖 For more information, see:"
echo "   - ./README.md"
echo "   - ./QUICK_START.md"
echo "   - ./API_DOCUMENTATION.md"
echo ""
echo "=================================="
