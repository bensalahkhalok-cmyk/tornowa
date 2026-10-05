#!/bin/bash

# League Management System - Start Script
# يشغل النظام كاملاً (Backend + Database + Frontend)

set -e

clear

cat << 'EOF'
╔════════════════════════════════════════════════════════════════════╗
║                                                                   ║
║  🚀 League Management System - نظام إدارة دوري كرة القدم          ║
║                                                                   ║
║    بدء النظام الكامل (Backend + Database + Frontend)             ║
║                                                                   ║
╚════════════════════════════════════════════════════════════════════╝

EOF

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check prerequisites
echo -e "${BLUE}🔍 فحص المتطلبات...${NC}"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js غير مثبت${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Node.js $(node --version)${NC}"

# Check npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm غير مثبت${NC}"
    exit 1
fi
echo -e "${GREEN}✅ npm $(npm --version)${NC}"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker غير مثبت${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Docker $(docker --version | cut -d' ' -f3 | cut -d',' -f1)${NC}"

echo ""
echo -e "${BLUE}═════════════════════════════════════════════════════${NC}"
echo ""

# Step 1: Start PostgreSQL
echo -e "${YELLOW}📦 الخطوة 1: بدء قاعدة البيانات (PostgreSQL)${NC}"
echo ""

cd /home/abdo/Desktop/leage

if docker-compose ps | grep -q "league_postgres"; then
    echo -e "${GREEN}✅ PostgreSQL بدأ بالفعل${NC}"
else
    echo "🔄 بدء PostgreSQL..."
    docker-compose up -d postgres 2>&1 | grep -E "(Starting|Created)" || true
    echo -e "${GREEN}✅ PostgreSQL في وضع التشغيل${NC}"
fi

echo "⏳ انتظار اتصال قاعدة البيانات..."
sleep 5

echo ""
echo -e "${BLUE}═════════════════════════════════════════════════════${NC}"
echo ""

# Step 2: Setup env and migrations
echo -e "${YELLOW}📋 الخطوة 2: إعداد قاعدة البيانات${NC}"
echo ""

cd /home/abdo/Desktop/leage/nest-js

if [ ! -f ".env" ]; then
    echo "📝 إنشاء ملف .env..."
    cat > .env << 'ENVEOF'
DATABASE_URL="postgresql://league_user:league_password@localhost:5432/league_db?schema=public"
JWT_SECRET="super_secret_jwt_key_change_in_production_12345"
PORT=3000
NODE_ENV="development"
CORS_ORIGIN="http://localhost:3000,http://localhost:8080,http://127.0.0.1:3000"
ENVEOF
    echo -e "${GREEN}✅ .env تم إنشاؤه${NC}"
else
    echo -e "${GREEN}✅ .env موجود بالفعل${NC}"
fi

echo ""
echo -e "${BLUE}═════════════════════════════════════════════════════${NC}"
echo ""

# Step 3: Start Backend
echo -e "${YELLOW}🔧 الخطوة 3: بدء Backend (NestJS)${NC}"
echo ""

if ! npm ls > /dev/null 2>&1; then
    echo "📥 تثبيت المكتبات..."
    npm install --silent 2>&1 | tail -3
else
    echo -e "${GREEN}✅ المكتبات مثبتة بالفعل${NC}"
fi

echo ""
echo "🚀 بدء خادم NestJS..."
npm run start:dev > /tmp/nestjs.log 2>&1 &
NEST_PID=$!
echo "PID: $NEST_PID"

echo "⏳ انتظار بدء الخادم..."
for i in {1..30}; do
    if curl -s http://localhost:3000/health &>/dev/null; then
        echo -e "${GREEN}✅ Backend جاهز على http://localhost:3000${NC}"
        break
    fi
    echo -n "."
    sleep 1
    if [ $i -eq 30 ]; then
        echo ""
        echo -e "${RED}❌ Backend لم يبدأ في الوقت المحدد${NC}"
        echo "🔍 السجلات:"
        tail -20 /tmp/nestjs.log
        exit 1
    fi
done

echo ""
echo -e "${BLUE}═════════════════════════════════════════════════════${NC}"
echo ""

# Step 4: Summary
echo -e "${YELLOW}📊 النظام جاهز!${NC}"
echo ""
echo -e "${GREEN}✅ جميع الخدمات تعمل:${NC}"
echo ""
echo -e "  ${BLUE}📡 API Backend${NC}"
echo "     URL: http://localhost:3000"
echo "     Health: http://localhost:3000/health"
echo ""
echo -e "  ${BLUE}📚 Swagger Documentation${NC}"
echo "     URL: http://localhost:3000/api/docs"
echo ""
echo -e "  ${BLUE}💾 Database (PostgreSQL)${NC}"
echo "     Host: localhost:5432"
echo "     Database: league_db"
echo "     User: league_user"
echo ""
echo -e "  ${BLUE}📊 PgAdmin (اختياري)${NC}"
echo "     URL: http://localhost:5050"
echo "     Email: admin@league.com"
echo "     Password: admin123"
echo ""

echo -e "${BLUE}═════════════════════════════════════════════════════${NC}"
echo ""

# Step 5: Next instructions
echo -e "${YELLOW}📖 الخطوات التالية:${NC}"
echo ""
echo "1️⃣ جرب API:"
echo "   curl http://localhost:3000/health"
echo ""
echo "2️⃣ تسجيل مستخدم جديد:"
cat << 'CURLEOF'
   curl -X POST http://localhost:3000/api/auth/register \
     -H "Content-Type: application/json" \
     -d '{
       "fullName": "أحمد محمد",
       "email": "ahmed@test.com",
       "phone": "+966501234567",
       "password": "password123",
       "role": "CAPTAIN"
     }'
CURLEOF
echo ""
echo "3️⃣ اختبر Swagger:"
echo "   افتح: http://localhost:3000/api/docs"
echo ""
echo "4️⃣ شغّل Flutter (في terminal آخر):"
echo "   cd /home/abdo/Desktop/leage/league_app"
echo "   flutter run"
echo ""
echo "5️⃣ اقرأ التوثيق:"
echo "   📄 DEPLOYMENT_GUIDE.md - دليل التشغيل الكامل"
echo "   📄 API_DOCUMENTATION.md - توثيق الـ API"
echo "   📄 QUICK_START.md - بدء سريع"
echo ""

echo -e "${BLUE}═════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${GREEN}🎉 النظام جاهز للعمل!${NC}"
echo ""
echo "اضغط Ctrl+C لإيقاف الخادم"
echo ""

# Keep the script running to maintain backend
wait $NEST_PID
