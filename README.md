# League Mini Football Management System

نظام شامل لإدارة دوري كرة القدم المصغرة بنية هرمية من الأدوار والصلاحيات.

## 📱 المشروع يتضمن:

### 1. **NestJS Backend** (`/home/abdo/Desktop/leage/nest-js`)
- ✅ مشروع NestJS كامل مهيأ
- ✅ JWT Authentication
- ✅ Prisma ORM + PostgreSQL Schema
- ✅ Swagger API Documentation
- ✅ RBAC (Role-Based Access Control)
- ✅ 4 Modules: Auth, Leagues, Teams, Matches
- ✅ CORS Enabled
- ✅ Global Validation Pipes

**File Structure:**
```
nest-js/
├── src/
│   ├── auth/
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── auth.module.ts
│   │   ├── strategies/jwt.strategy.ts
│   │   ├── guards/
│   │   │   ├── jwt-auth.guard.ts
│   │   │   └── roles.guard.ts
│   │   ├── decorators/roles.decorator.ts
│   │   └── dto/
│   ├── leagues/
│   ├── teams/
│   ├── matches/
│   ├── prisma/
│   │   ├── prisma.module.ts
│   │   └── prisma.service.ts
│   ├── common/
│   │   ├── enums/roles.enum.ts
│   │   └── types/league.types.ts
│   ├── generated/ (Prisma generated client)
│   ├── app.module.ts
│   ├── main.ts
├── prisma/
│   └── schema.prisma (Complete database schema)
├── docker-compose.yml (PostgreSQL)
├── package.json
└── tsconfig.json
```

### 2. **Flutter Mobile App** (`/home/abdo/Desktop/leage/league_app`)
- ✅ Flutter Project Structure
- ✅ Riverpod State Management
- ✅ GoRouter Navigation
- ✅ Dio HTTP Client
- ✅ API Models (User, League, Team, Match)
- ✅ 3 Role-Based Dashboards
- ✅ Authentication Screens (Login/Register)
- ✅ Arabic UI Support
- ✅ Material Design 3

**File Structure:**
```
league_app/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── routes/app_router.dart
│   │   ├── theme/app_theme.dart
│   │   └── services/api_client.dart
│   ├── features/
│   │   ├── auth/
│   │   │   ├── presentation/screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── register_screen.dart
│   │   │   └── data/models/user_model.dart
│   │   ├── organizer/
│   │   │   ├── presentation/screens/organizer_dashboard.dart
│   │   │   └── data/models/league_model.dart
│   │   ├── captain/
│   │   │   ├── presentation/screens/captain_dashboard.dart
│   │   │   └── data/models/team_model.dart
│   │   └── player/
│   │       ├── presentation/screens/player_dashboard.dart
│   │       └── data/models/match_model.dart
├── pubspec.yaml
└── README.md
```

## 🎯 نظام الأدوار الثلاثة

### 1. **منظم الدوري (Organizer)**
- إنشاء الدوريات
- توليد أكواد دعوة للكباتنز
- جدولة المباريات
- إدارة الملاعب
- عرض الترتيب والإحصائيات

### 2. **كابتن الفريق (Captain)**
- الانضمام عبر كود دعوة
- إنشاء فريقه
- دعوة اللاعبين
- إدارة التشكيلة
- تأكيد الحضور

### 3. **اللاعب (Player)**
- الانضمام عبر رابط الفريق
- عرض الملف الشخصي
- الإحصائيات
- تأكيد الحضور
- عرض المباريات والنتائج

## 🚀 الخطوات التالية

### 1. **تشغيل Backend (NestJS)**

```bash
cd /home/abdo/Desktop/leage/nest-js

# تثبيت الحزم (تم بالفعل)
npm install

# بدء خادم التطوير
npm run start:dev

# الـ API سيعمل على: http://localhost:3000
# Swagger Docs: http://localhost:3000/api/docs
```

### 2. **إعداد قاعدة البيانات (PostgreSQL)**

```bash
# تشغيل PostgreSQL عبر Docker
docker-compose up -d

# أو تثبيت PostgreSQL مباشرة على النظام
# https://www.postgresql.org/download/

# إنشاء Migration
npx prisma migrate dev --name init

# Seed البيانات (اختياري)
npx prisma db seed
```

### 3. **تشغيل تطبيق Flutter**

```bash
cd /home/abdo/Desktop/leage/league_app

# استعادة الحزم
flutter pub get

# تشغيل التطبيق
flutter run

# أو اختبار على الويب (للتطوير السريع)
flutter run -d chrome
```

## 📊 قاعدة البيانات Schema

**الجداول الرئيسية:**
- `users` - المستخدمون
- `roles` - الأدوار
- `permissions` - الصلاحيات
- `leagues` - الدوريات
- `league_invites` - أكواد الدعوة
- `teams` - الفرق
- `team_memberships` - عضويات الفريق
- `matches` - المباريات
- `standings` - جدول الترتيب
- `match_events` - أحداث المباريات
- `notifications` - التنبيهات
- `payments` - الدفعات

## 🔐 المصادقة والصلاحيات

- **JWT Tokens** - توقيع الرموز عند التسجيل
- **Bcryptjs** - تشفير كلمات المرور
- **RBAC** - نظام الأدوار والصلاحيات
- **JwtStrategy** - استراتيجية التحقق من الرموز
- **RolesGuard** - حماية المسارات بالأدوار

## 🧪 اختبار API

استخدم Swagger على: `http://localhost:3000/api/docs`

أو اختبر البendpoints باستخدام Postman:

### تسجيل مستخدم جديد
```
POST /api/auth/register
Content-Type: application/json

{
  "fullName": "أحمد محمد",
  "email": "ahmed@example.com",
  "phone": "+966501234567",
  "password": "password123",
  "role": "CAPTAIN"
}
```

### تسجيل الدخول
```
POST /api/auth/login
Content-Type: application/json

{
  "email": "ahmed@example.com",
  "password": "password123"
}
```

### إنشاء دوري
```
POST /api/leagues
Authorization: Bearer <token>
Content-Type: application/json

{
  "organizerId": "user-id",
  "name": "دوري القرية الأول",
  "maxTeams": 8
}
```

## 📱 ميزات التطبيق

✅ واجهات رسمية احترافية
✅ دعم اللغة العربية
✅ تجاوب مع جميع الأحجام
✅ ملفات تعريف المستخدمين
✅ إدارة الفرق
✅ جدولة المباريات
✅ الترتيب والإحصائيات
✅ التنبيهات الفورية
✅ نظام الدعوات
✅ تأكيد الحضور

## 🛠️ التقنيات المستخدمة

**Backend:**
- NestJS 10
- Prisma 6.15
- PostgreSQL 16
- JWT
- Passport.js
- Swagger
- Bcryptjs

**Frontend:**
- Flutter 3.x
- Riverpod 2.4
- GoRouter 12
- Dio 5.3
- Google Fonts
- Material Design 3

## 📝 الملاحظات

1. **API Base URL:** تغييرها في `lib/core/services/api_client.dart`
   ```dart
   const String baseUrl = 'http://localhost:3000/api';
   ```

2. **Firebase Cloud Messaging:** يمكن إضافته لاحقًا للإشعارات الفورية

3. **الدفع الإلكتروني:** يمكن دمج بوابات الدفع لاحقًا

4. **التقارير المتقدمة:** يمكن إضافة رسوم بيانية وتقارير تفصيلية

## 🚦 الحالة الحالية

- ✅ Backend - جاهز للتشغيل
- ✅ Frontend - جاهز للتطوير
- ✅ Database Schema - معرّف بالكامل
- ⏳ Database Runtime - بانتظار التشغيل

## 📞 الدعم والتطوير

للمزيد من الميزات والدعم، فضلاً اتصل أو أرسل رسالة إلى الفريق.

---

**تاريخ الإنشاء:** October 4, 2026
**الإصدار:** 1.0.0
