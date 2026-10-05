# 🚀 دليل البدء السريع - Quick Start Guide

## الخطوة 1️⃣: تثبيت المتطلبات

### المتطلبات المسبقة:
- **Node.js** v18+ ([تحميل](https://nodejs.org/))
- **Flutter** 3.0+ ([تحميل](https://flutter.dev/docs/get-started/install))
- **PostgreSQL** 14+ أو **Docker** و **Docker Compose**
- **Git** ([تحميل](https://git-scm.com/))

### التحقق من التثبيت:
```bash
node --version      # v18 أو أحدث
flutter --version   # 3.0 أو أحدث
docker --version    # اختياري للـ Database
psql --version      # اختياري (PostgreSQL)
```

---

## الخطوة 2️⃣: بدء قاعدة البيانات

### الخيار أ: استخدام Docker (موصى به)

```bash
cd /home/abdo/Desktop/leage/nest-js

# تشغيل PostgreSQL
docker-compose up -d

# التحقق من الحالة
docker ps

# إذا أردت إيقافه
docker-compose down
```

**معلومات الاتصال:**
- Host: `localhost`
- Port: `5432`
- User: `league_user`
- Password: `league_password`
- Database: `league_db`

### الخيار ب: PostgreSQL محلي

```bash
# Windows
# https://www.postgresql.org/download/windows/

# macOS
brew install postgresql

# Linux (Ubuntu/Debian)
sudo apt-get install postgresql postgresql-contrib

# بدء الخدمة
sudo service postgresql start
```

---

## الخطوة 3️⃣: إعداد Backend (NestJS)

```bash
cd /home/abdo/Desktop/leage/nest-js

# التحقق من الحزم (تم بالفعل)
npm install

# إنشاء ملف .env
cat > .env << EOF
DATABASE_URL="postgresql://league_user:league_password@localhost:5432/league_db?schema=public"
JWT_SECRET="your_super_secret_jwt_key_change_this_in_production"
PORT=3000
EOF

# تشغيل Prisma Migrations
npx prisma migrate dev --name init

# اختياري: Seed البيانات (ستضيف بيانات تجريبية)
npx prisma db seed

# بدء خادم التطوير
npm run start:dev
```

✅ **سيعمل backend على:** http://localhost:3000

📚 **Swagger API Docs:** http://localhost:3000/api/docs

---

## الخطوة 4️⃣: إعداد Frontend (Flutter)

```bash
cd /home/abdo/Desktop/leage/league_app

# استعادة الحزم
flutter pub get

# التحقق من البيئة
flutter doctor

# بدء التطبيق
flutter run

# أو على الويب (Chrome)
flutter run -d chrome
```

### تشغيل على أجهزة محددة:

```bash
# قائمة الأجهزة المتاحة
flutter devices

# تشغيل على جهاز محدد
flutter run -d <device-id>

# تشغيل على محاكي
flutter run -d emulator-5554
```

---

## الخطوة 5️⃣: أول تسجيل

### في التطبيق:

1. **افتح شاشة التسجيل**
2. **اختر الدور:**
   - 🧑‍💼 Organizer (منظم الدوري)
   - 👨‍💼 Captain (كابتن الفريق)
   - ⚽ Player (لاعب)

3. **أدخل البيانات:**
   ```
   الاسم: أحمد محمد
   الهاتف: +966501234567
   البريد: ahmed@example.com
   كلمة المرور: password123
   ```

4. **انقر "تسجيل"**

5. **ستنتقل تلقائيًا إلى لوحة التحكم الخاصة بك**

---

## 📋 الاختبار عبر Swagger

1. افتح: http://localhost:3000/api/docs
2. انقر على **"Authorize"** (الأيقونة الزرقاء في الأعلى)
3. أدخل الـ JWT Token من عملية Login
4. ابدأ باختبار الـ Endpoints

### مثال على Flow اختبار:

```
1. POST /auth/register → احصل على token
2. POST /auth/login → انسخ access_token
3. استخدم الـ token في Authorize
4. POST /leagues → أنشئ دوري
5. PUT /leagues/{id}/generate-invite → أنشئ كود دعوة
6. واستمر...
```

---

## 🔧 الأوامر الشائعة

### Backend (NestJS)

```bash
cd /home/abdo/Desktop/leage/nest-js

# بدء التطوير
npm run start:dev

# البناء للإنتاج
npm run build

# تشغيل في وضع الإنتاج
npm run start:prod

# الاختبارات
npm run test

# الاختبارات بالتغطية
npm run test:cov
```

### Database (Prisma)

```bash
# الترقيات
npx prisma migrate dev

# إعادة تعيين قاعدة البيانات
npx prisma migrate reset

# فتح Studio (واجهة رسمية للـ Database)
npx prisma studio

# توليد الـ Client
npx prisma generate
```

### Frontend (Flutter)

```bash
# تشغيل
flutter run

# بناء APK (Android)
flutter build apk

# بناء iOS
flutter build ios

# بناء الويب
flutter build web

# التنظيف
flutter clean

# الحصول على الحزم
flutter pub get

# الترقية
flutter pub upgrade
```

---

## 🐛 استكشاف الأخطاء

### Backend لا يعمل

```bash
# تحقق من الأتصال بـ PostgreSQL
psql -U league_user -h localhost -d league_db

# أعد مثبت الحزم
rm -rf node_modules package-lock.json
npm install

# أعد تشغيل Migrations
npx prisma migrate reset
```

### Frontend لا يعمل

```bash
# نظف المشروع
flutter clean

# استعد الحزم
flutter pub get

# تحقق من الإصدارات
flutter doctor -v

# جرب على الويب أولاً
flutter run -d chrome
```

### API لا تستجيب

```bash
# تحقق من الـ Backend يعمل
curl http://localhost:3000/health

# تحقق من قاعدة البيانات
# في ملف .env - DATABASE_URL صحيح؟

# شغل Migrations مرة أخرى
npx prisma migrate deploy
```

---

## 📊 بيانات تجريبية

بعد تشغيل `npx prisma db seed`، ستحصل على:

```
👤 3 مستخدمين اختبار:
  - organizer@test.com (منظم)
  - captain@test.com (كابتن)
  - player@test.com (لاعب)

🏆 1 دوري اختباري

👥 2 فريق اختباري

⚽ 5 مباريات جاهزة
```

---

## 🚨 ملاحظات مهمة

1. **غير كلمة المرور في الإنتاج!**
   ```bash
   # في .env
   JWT_SECRET="استخدم مفتاح عشوائي قوي"
   ```

2. **غيّر DATABASE_URL في الإنتاج**
   ```bash
   DATABASE_URL="postgresql://user:pass@prod-host:5432/db"
   ```

3. **للتطبيق على أجهزة حقيقية:**
   - تحديث baseUrl في Flutter
   - تحديث CORS في NestJS
   - الاتصال بـ DNS الحقيقي بدلاً من localhost

4. **نسخ احتياطي لقاعدة البيانات:**
   ```bash
   pg_dump -U league_user league_db > backup.sql
   psql -U league_user league_db < backup.sql
   ```

---

## ✅ Checklist الاستعداد

- [ ] Node.js مثبت
- [ ] Flutter مثبت
- [ ] Docker/PostgreSQL يعمل
- [ ] Backend يعمل على :3000
- [ ] Swagger يفتح بدون أخطاء
- [ ] Flutter تم تشغيله بدون أخطاء
- [ ] يمكنك التسجيل وإنشاء حساب
- [ ] يمكنك إنشاء دوري (للمنظمين)

---

## 🎉 مبروك!

أنت الآن جاهز للبدء بالتطوير على النظام الكامل.

📚 للمزيد من المعلومات:
- [NestJS Docs](https://docs.nestjs.com)
- [Prisma Docs](https://www.prisma.io/docs/)
- [Flutter Docs](https://flutter.dev/docs)

---

**آخر تحديث:** October 4, 2026
