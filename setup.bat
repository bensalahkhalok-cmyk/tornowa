@echo off
REM League Management System - Local Development Setup Script (Windows)
REM This script automates the setup process for development environment

setlocal enabledelayedexpansion

echo.
echo ==================================
echo. League Management System Setup
echo ==================================
echo.

REM Check Node.js
echo [INFO] Checking prerequisites...
node --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [X] Node.js is not installed. Please install from https://nodejs.org/
    pause
    exit /b 1
)
echo [OK] Node.js is installed

REM Check Flutter (optional)
flutter --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [!] Flutter is not installed. Install from https://flutter.dev
) else (
    echo [OK] Flutter is installed
)

REM Check Docker (optional)
docker --version >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo [OK] Docker is installed
) else (
    echo [!] Docker is not installed. Ensure PostgreSQL is running locally.
)

echo.

REM Setup Backend
echo [INFO] Setting up NestJS Backend...

set BACKEND_DIR=C:\Users\%USERNAME%\Desktop\leage\nest-js

if not exist "%BACKEND_DIR%" (
    echo [X] Backend directory not found at: %BACKEND_DIR%
    pause
    exit /b 1
)

cd /d "%BACKEND_DIR%"

REM Install dependencies
if not exist "node_modules" (
    echo [INFO] Installing backend dependencies...
    call npm install
    if %ERRORLEVEL% neq 0 (
        echo [X] Failed to install dependencies
        pause
        exit /b 1
    )
    echo [OK] Backend dependencies installed
) else (
    echo [OK] Backend dependencies already installed
)

REM Create .env file
if not exist ".env" (
    echo [INFO] Creating .env file...
    (
        echo DATABASE_URL=postgresql://league_user:league_password@localhost:5432/league_db?schema=public
        echo JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
        echo PORT=3000
        echo NODE_ENV=development
        echo CORS_ORIGIN=http://localhost:3000,http://localhost:8080,http://127.0.0.1:3000
    ) > .env
    echo [OK] .env file created
) else (
    echo [OK] .env file already exists
)

REM Build the project
echo [INFO] Building backend...
call npm run build
if %ERRORLEVEL% neq 0 (
    echo [X] Build failed
    pause
    exit /b 1
)
echo [OK] Backend built successfully

echo.

REM Setup Database
echo [INFO] Checking database setup...

docker ps 2>nul | find "postgres" >nul
if !ERRORLEVEL! equ 0 (
    echo [OK] PostgreSQL is already running
) else (
    if exist "docker-compose.yml" (
        echo [INFO] Starting PostgreSQL with Docker Compose...
        call docker-compose up -d
        if !ERRORLEVEL! equ 0 (
            timeout /t 5 /nobreak
            echo [OK] PostgreSQL started
        )
    ) else (
        echo [!] Please ensure PostgreSQL is running on localhost:5432
    )
)

echo.

REM Run Prisma migrations
echo [INFO] Running Prisma migrations...
call npx prisma migrate deploy
echo [OK] Migrations completed

echo.

REM Setup Frontend (optional)
set /p SETUP_FLUTTER="Setup Flutter frontend? (y/n): "
if /i "%SETUP_FLUTTER%"=="y" (
    set FRONTEND_DIR=C:\Users\%USERNAME%\Desktop\leage\league_app
    
    if not exist "%FRONTEND_DIR%" (
        echo [X] Frontend directory not found: %FRONTEND_DIR%
    ) else (
        cd /d "%FRONTEND_DIR%"
        
        echo [INFO] Installing Flutter dependencies...
        call flutter pub get
        echo [OK] Flutter dependencies installed
    )
)

echo.
echo ==================================
echo [OK] Setup completed!
echo ==================================
echo.
echo Next steps:
echo.
echo 1) Start the backend (in new terminal):
echo    cd "%BACKEND_DIR%"
echo    npm run start:dev
echo.
echo 2) Backend will be available at:
echo    API: http://localhost:3000/api
echo    Docs: http://localhost:3000/api/docs
echo.
echo 3) Start the mobile app (in new terminal):
echo    cd C:\Users\%USERNAME%\Desktop\leage\league_app
echo    flutter run
echo.
echo For more information, see:
echo    - README.md
echo    - QUICK_START.md
echo    - API_DOCUMENTATION.md
echo.
echo ==================================
echo.
pause
