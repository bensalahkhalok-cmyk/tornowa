# 📁 Project Structure Overview

## المشروع الكامل - League Management System

```
/home/abdo/Desktop/leage/
│
├── 📄 README.md                      # Main project README
├── 📄 QUICK_START.md                 # Quick start guide
├── 📄 API_DOCUMENTATION.md           # Detailed API docs
├── 📄 ARCHITECTURE.md                # Architecture & design patterns
├── 📄 CONTRIBUTING.md                # Contribution guidelines
├── 📄 CHANGELOG.md                   # Release notes & changelog
├── 📄 LICENSE                        # MIT License
├── 📄 .gitignore                     # Git ignore rules
│
├── 📄 setup.sh                       # Setup script (Linux/macOS)
├── 📄 setup.bat                      # Setup script (Windows)
│
├── 📄 docker-compose.yml             # PostgreSQL + PgAdmin
├── 📄 docker-compose-full.yml        # Full stack with Redis
│
├── 📁 nest-js/                       # NestJS Backend
│   │
│   ├── 📄 package.json               # Dependencies
│   ├── 📄 tsconfig.json              # TypeScript config
│   ├── 📄 .eslintrc.js               # ESLint config
│   ├── 📄 nest-cli.json              # NestJS CLI config
│   ├── 📄 .env.example               # Environment template
│   │
│   ├── 📁 src/
│   │   │
│   │   ├── 📁 auth/                  # Authentication Module
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.service.ts
│   │   │   ├── auth.module.ts
│   │   │   ├── 📁 strategies/
│   │   │   │   └── jwt.strategy.ts
│   │   │   ├── 📁 guards/
│   │   │   │   ├── jwt-auth.guard.ts
│   │   │   │   └── roles.guard.ts
│   │   │   ├── 📁 decorators/
│   │   │   │   ├── current-user.decorator.ts
│   │   │   │   └── roles.decorator.ts
│   │   │   └── 📁 dto/
│   │   │       ├── register.dto.ts
│   │   │       ├── login.dto.ts
│   │   │       └── update-profile.dto.ts
│   │   │
│   │   ├── 📁 leagues/               # Leagues Module
│   │   │   ├── leagues.controller.ts
│   │   │   ├── leagues.service.ts
│   │   │   ├── leagues.module.ts
│   │   │   └── 📁 dto/
│   │   │       ├── create-league.dto.ts
│   │   │       ├── update-league.dto.ts
│   │   │       └── league-invite.dto.ts
│   │   │
│   │   ├── 📁 teams/                 # Teams Module
│   │   │   ├── teams.controller.ts
│   │   │   ├── teams.service.ts
│   │   │   ├── teams.module.ts
│   │   │   └── 📁 dto/
│   │   │       ├── create-team.dto.ts
│   │   │       └── add-player.dto.ts
│   │   │
│   │   ├── 📁 matches/               # Matches Module
│   │   │   ├── matches.controller.ts
│   │   │   ├── matches.service.ts
│   │   │   ├── matches.module.ts
│   │   │   └── 📁 dto/
│   │   │       ├── create-match.dto.ts
│   │   │       ├── update-score.dto.ts
│   │   │       └── match-event.dto.ts
│   │   │
│   │   ├── 📁 prisma/                # Database Service
│   │   │   ├── prisma.module.ts
│   │   │   └── prisma.service.ts
│   │   │
│   │   ├── 📁 common/                # Shared Utilities
│   │   │   ├── 📁 enums/
│   │   │   │   ├── roles.enum.ts
│   │   │   │   ├── match-status.enum.ts
│   │   │   │   ├── league-status.enum.ts
│   │   │   │   └── membership-status.enum.ts
│   │   │   ├── 📁 types/
│   │   │   │   ├── league.types.ts
│   │   │   │   └── team.types.ts
│   │   │   ├── 📁 interfaces/
│   │   │   │   └── user.interface.ts
│   │   │   ├── 📁 filters/
│   │   │   │   └── http-exception.filter.ts
│   │   │   └── 📁 interceptors/
│   │   │       └── logging.interceptor.ts
│   │   │
│   │   ├── 📁 generated/             # Prisma Generated (Auto)
│   │   │   └── index.d.ts
│   │   │
│   │   ├── app.module.ts             # Root Module
│   │   └── main.ts                   # Entry Point
│   │
│   ├── 📁 prisma/
│   │   └── schema.prisma             # Database Schema
│   │
│   ├── 📁 dist/                      # Compiled Output (Generated)
│   ├── 📁 node_modules/              # Dependencies (Generated)
│   └── 📁 test/                      # Test Files
│
├── 📁 league_app/                    # Flutter Mobile App
│   │
│   ├── 📄 pubspec.yaml               # Flutter dependencies
│   ├── 📄 pubspec.lock               # Locked versions
│   ├── 📄 analysis_options.yaml      # Linter config
│   │
│   ├── 📁 lib/
│   │   │
│   │   ├── main.dart                 # App Entry Point
│   │   │
│   │   ├── 📁 core/                  # Core Services
│   │   │   ├── 📁 routes/
│   │   │   │   └── app_router.dart
│   │   │   ├── 📁 theme/
│   │   │   │   ├── app_theme.dart
│   │   │   │   └── app_colors.dart
│   │   │   ├── 📁 services/
│   │   │   │   ├── api_client.dart
│   │   │   │   ├── storage_service.dart
│   │   │   │   └── notification_service.dart
│   │   │   └── 📁 constants/
│   │   │       └── app_constants.dart
│   │   │
│   │   ├── 📁 features/              # Feature Modules
│   │   │   │
│   │   │   ├── 📁 auth/              # Authentication Feature
│   │   │   │   ├── 📁 data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   └── user_model.dart
│   │   │   │   │   └── providers/
│   │   │   │   │       └── auth_provider.dart
│   │   │   │   └── 📁 presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   └── auth_notifier.dart
│   │   │   │       └── screens/
│   │   │   │           ├── login_screen.dart
│   │   │   │           └── register_screen.dart
│   │   │   │
│   │   │   ├── 📁 leagues/           # Leagues Feature
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   └── league_model.dart
│   │   │   │   │   └── providers/
│   │   │   │   │       └── league_provider.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── screens/
│   │   │   │       └── widgets/
│   │   │   │
│   │   │   ├── 📁 teams/             # Teams Feature
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   └── team_model.dart
│   │   │   │   │   └── providers/
│   │   │   │   │       └── team_provider.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── screens/
│   │   │   │       └── widgets/
│   │   │   │
│   │   │   ├── 📁 matches/           # Matches Feature
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   └── match_model.dart
│   │   │   │   │   └── providers/
│   │   │   │   │       └── match_provider.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── screens/
│   │   │   │       └── widgets/
│   │   │   │
│   │   │   ├── 📁 organizer/         # Organizer Dashboard
│   │   │   │   └── presentation/
│   │   │   │       └── screens/
│   │   │   │           └── organizer_dashboard.dart
│   │   │   │
│   │   │   ├── 📁 captain/           # Captain Dashboard
│   │   │   │   └── presentation/
│   │   │   │       └── screens/
│   │   │   │           └── captain_dashboard.dart
│   │   │   │
│   │   │   └── 📁 player/            # Player Dashboard
│   │   │       └── presentation/
│   │   │           └── screens/
│   │   │               └── player_dashboard.dart
│   │   │
│   │   ├── 📁 shared/                # Shared Components
│   │   │   ├── 📁 widgets/
│   │   │   │   ├── custom_app_bar.dart
│   │   │   │   ├── custom_button.dart
│   │   │   │   ├── loading_indicator.dart
│   │   │   │   └── error_widget.dart
│   │   │   └── 📁 utils/
│   │   │       ├── validators.dart
│   │   │       └── formatters.dart
│   │   │
│   │   └── 📁 generated/             # Generated Code (Auto)
│   │
│   ├── 📁 android/                   # Android Native Code
│   ├── 📁 ios/                       # iOS Native Code
│   ├── 📁 web/                       # Web Build
│   ├── 📁 windows/                   # Windows Build
│   ├── 📁 macos/                     # macOS Build
│   ├── 📁 linux/                     # Linux Build
│   │
│   ├── 📁 test/                      # Unit Tests
│   ├── 📁 integration_test/          # Integration Tests
│   │
│   └── 📁 .dart_tool/                # Generated (Auto)
│
└── 📁 docs/ (Optional - Future)      # Additional Documentation
    ├── api-endpoints.md
    ├── database-schema.md
    ├── user-flows.md
    └── deployment-guide.md
```

---

## 📊 أحجام الملفات الموجودة

### Backend (NestJS)
- **package.json** - تصريحات الحزم
- **src/main.ts** - نقطة الدخول
- **src/app.module.ts** - الوحدة الرئيسية
- **prisma/schema.prisma** - مخطط قاعدة البيانات
- **dist/** - الملفات المترجمة (بعد البناء)
- **node_modules/** - المكتبات المثبتة (~500MB)

### Frontend (Flutter)
- **lib/main.dart** - نقطة الدخول
- **pubspec.yaml** - تصريحات الحزم
- **lib/core/** - الخدمات الأساسية
- **lib/features/** - وحدات الميزات
- **build/** - الملفات المترجمة (بعد البناء)
- **.dart_tool/** - أدوات Dart (بعد pub get)

---

## 🔑 الملفات المهمة

### للبدء السريع
1. ✅ `README.md` - ابدأ هنا
2. ✅ `QUICK_START.md` - خطوات التثبيت
3. ✅ `setup.sh` / `setup.bat` - التثبيت الآلي

### للتطوير
1. ✅ `ARCHITECTURE.md` - فهم البنية
2. ✅ `API_DOCUMENTATION.md` - شرح الـ API
3. ✅ `CONTRIBUTING.md` - تعليمات المساهمة

### للنشر
1. ✅ `docker-compose.yml` - إعدادات Docker
2. ✅ `.env.example` - متغيرات البيئة
3. ✅ `CHANGELOG.md` - سجل التغييرات

---

## 🔗 الملفات المرتبطة

### Database
- `nest-js/prisma/schema.prisma` - تعريف الجداول
- `docker-compose.yml` - إعدادات PostgreSQL

### API
- `nest-js/src/app.module.ts` - تسجيل الوحدات
- `nest-js/src/main.ts` - تثبيت Swagger
- `nest-js/src/auth/auth.module.ts` - وحدة المصادقة

### لوحات المعلومات
- `league_app/lib/features/organizer/` - لوحة منظم
- `league_app/lib/features/captain/` - لوحة كابتن
- `league_app/lib/features/player/` - لوحة لاعب

---

## 📝 الملفات التي يجب تجاهلها (gitignore)

- `node_modules/` - مكتبات Node
- `.env` - متغيرات سرية
- `dist/` و `build/` - ملفات مترجمة
- `.dart_tool/` و `.pub-cache/` - ملفات Dart المؤقتة
- `ios/Pods/` و `.dart_plugin_registrant.dart` - ملفات iOS
- `*.log` - ملفات السجلات
- `.DS_Store` - ملفات macOS

---

## 🚀 ملخص الخطوات

### 1. بدء التطوير
```bash
cd /home/abdo/Desktop/leage
./setup.sh  # أو setup.bat على Windows
```

### 2. بدء Backend
```bash
cd nest-js
npm run start:dev
# الذهاب إلى: http://localhost:3000/api/docs
```

### 3. بدء Frontend
```bash
cd league_app
flutter run
```

### 4. اختبار الـ API
```bash
# استخدم Swagger: http://localhost:3000/api/docs
# أو استخدم Postman/cURL
```

---

**آخر تحديث:** October 4, 2026

