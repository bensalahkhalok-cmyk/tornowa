# 🚀 دليل التشغيل الفعلي - Deployment & Running Guide

## المتطلبات الأساسية ✅

- ✅ **Node.js v18+** - مثبت (v20.20.0)
- ✅ **npm v8+** - مثبت (10.8.2)
- ✅ **Docker** - مثبت (29.1.3)
- ✅ **Git** - مثبت
- ⚠️ **Flutter** - اختياري (للتطبيق الموبايل)

---

## 📋 الخطوة 1: إعداد قاعدة البيانات

### أولاً: تشغيل PostgreSQL عبر Docker

```bash
cd /home/abdo/Desktop/leage

# تثبيت docker-compose إذا لم يكن مثبتاً
sudo apt-get install docker-compose -y

# بدء PostgreSQL
docker-compose up -d
```

**التحقق من حالة الحاوية:**
```bash
docker ps
# يجب أن تري حاوية "league_postgres" و "league_pgadmin"
```

**الوصول إلى PgAdmin (اختياري):**
- URL: http://localhost:5050
- البريد: admin@league.com
- كلمة المرور: admin123

### ثانياً: تشغيل Prisma Migrations

```bash
cd nest-js

# إنشاء قاعدة البيانات والجداول
npx prisma migrate deploy

# أو للتطوير (مع seed):
npx prisma migrate dev
```

---

## 🔧 الخطوة 2: بدء Backend (NestJS)

### الطريقة 1: التطوير (Development)

```bash
cd /home/abdo/Desktop/leage/nest-js

# تثبيت المكتبات إذا لم تكن مثبتة
npm install

# بدء الخادم مع المراقبة التلقائية
npm run start:dev
```

**المخرجات المتوقعة:**
```
[Nest] 12345 - 10/04/2026, 10:00:00 AM     LOG [NestFactory] Starting Nest application...
[Nest] 12345 - 10/04/2026, 10:00:00 AM     LOG [InstanceLoader] AppModule dependencies initialized +10ms
[Nest] 12345 - 10/04/2026, 10:00:00 AM     LOG [RoutesResolver] AppController {/}: 2
[Nest] 12345 - 10/04/2026, 10:00:00 AM     LOG [NestApplication] Nest application successfully started
[Nest] 12345 - 10/04/2026, 10:00:00 AM     LOG Application is running on: http://localhost:3000
```

### الطريقة 2: الإنتاج (Production)

```bash
cd nest-js

# البناء
npm run build

# التشغيل
npm run start:prod
```

---

## 📱 الخطوة 3: تشغيل Frontend (Flutter)

### المتطلبات الأولية:

```bash
# تثبيت Flutter (إذا لم يكن مثبتاً)
# https://flutter.dev/docs/get-started/install

# التحقق من التثبيت
flutter --version
flutter doctor
```

### تشغيل التطبيق:

```bash
cd /home/abdo/Desktop/leage/league_app

# استعادة المكتبات
flutter pub get

# تشغيل على جهاز محاكي/هاتف
flutter run

# أو على الويب
flutter run -d chrome

# أو على Windows
flutter run -d windows
```

---

## 🧪 الخطوة 4: اختبار النظام

### 1️⃣ اختبار البيانات:

```bash
# التحقق من العمل على localhost:3000
curl http://localhost:3000/health
```

### 2️⃣ Swagger API Documentation:

**الرابط:** http://localhost:3000/api/docs

**الخطوات:**
1. افتح المتصفح على الرابط أعلاه
2. انقر على "Authorize" (الأيقونة الزرقاء)
3. قم بتسجيل دخول أو إنشاء حساب
4. انسخ الـ JWT Token
5. ألصقها في "Authorize" مع كلمة "Bearer"
6. اختبر الـ Endpoints

### 3️⃣ اختبار تسجيل مستخدم جديد:

```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "أحمد محمد",
    "email": "ahmed@test.com",
    "phone": "+966501234567",
    "password": "password123",
    "role": "CAPTAIN"
  }'
```

**النتيجة المتوقعة:**
```json
{
  "id": "user-uuid",
  "fullName": "أحمد محمد",
  "email": "ahmed@test.com",
  "phone": "+966501234567",
  "role": "CAPTAIN",
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "token_type": "Bearer"
}
```

### 4️⃣ اختبار تسجيل الدخول:

```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "ahmed@test.com",
    "password": "password123"
  }'
```

### 5️⃣ اختبار إنشاء دوري:

```bash
TOKEN="your_jwt_token_here"

curl -X POST http://localhost:3000/api/leagues \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "دوري القرية الصيفي",
    "maxTeams": 8
  }'
```

---

## 🐛 استكشاف الأخطاء

### مشكلة: Backend لا يبدأ

**الحل:**
```bash
# 1. تحقق من المنفذ 3000
lsof -i :3000

# 2. قتل العملية إذا كانت تعمل
kill -9 <PID>

# 3. تحقق من ملف .env
cat nest-js/.env

# 4. جرب بناء جديد
cd nest-js && rm -rf dist && npm run build
```

### مشكلة: قاعدة البيانات لا تتصل

**الحل:**
```bash
# 1. تحقق من Docker
docker ps

# 2. شغّل PostgreSQL
docker-compose up -d

# 3. انتظر 10 ثوان
sleep 10

# 4. جرب الاتصال
curl http://localhost:3000/api/health
```

### مشكلة: Migrations فشلت

**الحل:**
```bash
cd nest-js

# 1. حذف وإعادة إنشاء
npx prisma migrate reset

# 2. أو يدويًا
npx prisma db push
```

---

## 📊 مؤشرات النجاح

### ✅ Backend يعمل بنجاح:
- [ ] الخادم يبدأ بدون أخطاء
- [ ] `npm run start:dev` ينتج رسالة "Application is running"
- [ ] `curl http://localhost:3000/health` يعيد نتيجة
- [ ] Swagger متاح على `http://localhost:3000/api/docs`

### ✅ قاعدة البيانات جاهزة:
- [ ] PostgreSQL container يعمل (`docker ps`)
- [ ] Migration نجحت بدون أخطاء
- [ ] `PgAdmin` متاح على http://localhost:5050

### ✅ Frontend يعمل:
- [ ] `flutter run` ينجح بدون أخطاء
- [ ] التطبيق يظهر على الهاتف/المحاكي
- [ ] شاشة Login تظهر بشكل صحيح

### ✅ الاتصال يعمل:
- [ ] يمكن تسجيل حساب جديد
- [ ] يمكن تسجيل الدخول
- [ ] الـ Token يتم إرجاعه بشكل صحيح
- [ ] يمكن الوصول إلى Swagger

---

## 🎯 سيناريوهات الاختبار الكاملة

### السيناريو الأول: تسجيل منظم دوري جديد

```bash
# 1. تسجيل
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "محمد الإدارة",
    "email": "organizer@test.com",
    "phone": "+966505555555",
    "password": "admin123",
    "role": "SUPER_ADMIN"
  }' | jq '.access_token' > token.txt

# 2. استخراج Token
TOKEN=$(cat token.txt | tr -d '"')

# 3. إنشاء دوري جديد
curl -X POST http://localhost:3000/api/leagues \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "دوري الخريف 2026",
    "maxTeams": 8,
    "description": "دوري مصغر للفريق"
  }' | jq '.'
```

### السيناريو الثاني: كابتن ينضم لدوري

```bash
# 1. تسجيل كابتن
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "علي كابتن",
    "email": "captain@test.com",
    "phone": "+966509999999",
    "password": "captain123",
    "role": "CAPTAIN"
  }' | jq '.access_token' > captain_token.txt

# 2. استخراج Token الكابتن
CAPTAIN_TOKEN=$(cat captain_token.txt | tr -d '"')

# 3. استخدام كود الدعوة للانضمام (بعد أن ينشئ المنظم الكود)
curl -X POST http://localhost:3000/api/leagues/verify-invite \
  -H "Authorization: Bearer $CAPTAIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "LEAGUE2026CAPTAIN"
  }' | jq '.'
```

---

## 📊 المشاهد المتقدمة

### عرض جميع الدوريات:
```bash
TOKEN="your_token"
curl -X GET http://localhost:3000/api/leagues \
  -H "Authorization: Bearer $TOKEN" | jq '.'
```

### إنشاء فريق:
```bash
TOKEN="your_token"
curl -X POST http://localhost:3000/api/teams \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "فريق الشرقية",
    "leagueId": "league-id-here",
    "colors": "#FF0000"
  }' | jq '.'
```

### جدولة مباراة:
```bash
TOKEN="your_token"
curl -X POST http://localhost:3000/api/matches \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "leagueId": "league-id",
    "homeTeamId": "team-1-id",
    "awayTeamId": "team-2-id",
    "scheduledAt": "2026-10-10T18:00:00Z",
    "stadium": "ملعب المدينة"
  }' | jq '.'
```

---

## 🔄 أوامر مفيدة

### إعادة تشغيل النظام:

```bash
# قتل جميع العمليات
pkill -f "npm run start"
pkill -f "flutter run"

# حذف قاعدة البيانات وإعادة إنشاء
cd nest-js
npx prisma migrate reset

# بدء من جديد
npm run start:dev
```

### المراحل/الصيانة:

```bash
# عرض السجلات (logs)
docker logs league_postgres
docker-compose logs

# إيقاف Docker
docker-compose down

# حذف كل شيء
docker-compose down -v
```

---

## 🎓 الملفات المرجعية

📄 [README.md](README.md) - نظرة عامة  
📄 [QUICK_START.md](QUICK_START.md) - بدء سريع  
📄 [API_DOCUMENTATION.md](API_DOCUMENTATION.md) - توثيق API  
📄 [ARCHITECTURE.md](ARCHITECTURE.md) - البنية المعمارية  

---

## 🎉 التم بنجاح!

عند اتباع الخطوات أعلاه، سيكون لديك:

✅ **Backend API** في http://localhost:3000  
✅ **Swagger Docs** في http://localhost:3000/api/docs  
✅ **قاعدة بيانات** جاهزة وتعمل  
✅ **تطبيق Mobile** جاهز للاختبار  
✅ **10+ API Endpoints** جاهزة للاستخدام  

---

**آخر تحديث:** October 4, 2026  
**الحالة:** ✅ جاهز للإطلاق
