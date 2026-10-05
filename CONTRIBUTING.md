# 🤝 Contributing Guide

شكراً لاهتمامك بالمساهمة في نظام إدارة دوري كرة القدم! يرجى اتباع التعليمات التالية.

## 📋 قواعد المساهمة

### 1. جهز بيئتك

```bash
# استنسخ المستودع
git clone <repo-url>
cd leage

# ثبت والمتطلبات
./setup.sh  # Linux/macOS
# أو
setup.bat   # Windows

# أنشئ فرع للميزة الجديدة
git checkout -b feature/your-feature-name
```

### 2. معايير الترميز

#### NestJS Backend

```typescript
// ✅ جيد
export class LeaguesService {
  constructor(private prisma: PrismaService) {}

  async createLeague(
    dto: CreateLeagueDto,
    user: User,
  ): Promise<League> {
    // Implementation
  }
}

// ❌ سيء
export class LeaguesService{
constructor(private prisma:PrismaService){}
async createLeague(dto:CreateLeagueDto, user:User){
// Implementation
}
}
```

**Rules:**
- استخدم **PascalCase** للـ Classes و Interfaces
- استخدم **camelCase** للـ Functions و Variables
- استخدم **UPPER_SNAKE_CASE** للـ Constants
- أضف tslint/eslint comments حسب الحاجة
- غطِّ الكود بـ Unit Tests

#### Flutter

```dart
// ✅ جيد
class OrganizerDashboard extends ConsumerWidget {
  const OrganizerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(child: Text('Welcome')),
    );
  }
}

// ❌ سيء
class OrganizerDashboard extends ConsumerWidget {
  OrganizerDashboard();
  @override
  Widget build(context,ref){
return Scaffold(appBar: AppBar(title: Text('Dashboard')),
body: Center(child: Text('Welcome')));}
}
```

**Rules:**
- استخدم `const` constructors حيث يكون ممكناً
- فصل الـ States والـ Widgets
- استخدم Riverpod للـ State Management
- أضف meaningful comments

### 3. رسائل الـ Commits

```bash
# ✅ جيد
git commit -m "feat: add league creation endpoint with validation"
git commit -m "refactor: optimize database queries for standings"
git commit -m "fix: resolve token expiration issue in auth guard"
git commit -m "docs: update API documentation for matches"
git commit -m "test: add unit tests for leagues service"

# ❌ سيء
git commit -m "updated code"
git commit -m "fixes"
git commit -m "WIP"
git commit -m "asdf"
```

**Format:** `<type>: <subject>`

Types:
- `feat`: new feature
- `fix`: bug fix
- `docs`: documentation
- `style`: formatting (no logic change)
- `refactor`: code restructuring
- `test`: adding tests
- `perf`: performance improvement

### 4. Pull Requests

```markdown
## وصف الميزة
وصف واضح للتغييرات المقترحة.

## النوع
- [ ] ميزة جديدة
- [ ] إصلاح عيب
- [ ] تحسين الأداء
- [ ] توثيق
- [ ] إعادة بناء

## الاختبارات
- [ ] تم اختبار التغييرات محلياً
- [ ] تم إضافة اختبارات جديدة
- [ ] جميع الاختبارات تمر

## التحقق من القائمة
- [ ] الكود يتبع معايير المشروع
- [ ] التوثيق محدثة
- [ ] لا توجد أخطاء شاشة العكس

## لقطات شاشة (اختيارية)
[أضف لقطات شاشة إن وجدت]

## الملاحظات الإضافية
أي معلومات إضافية مهمة
```

---

## 🧪 الاختبار المحلي

### Backend Testing

```bash
cd nest-js

# تشغيل جميع الاختبارات
npm test

# اختبارات مراقب الملفات
npm run test:watch

# تغطية الاختبارات
npm run test:cov
```

### Frontend Testing

```bash
cd league_app

# تشغيل الاختبارات
flutter test

# اختبارات مع التغطية
flutter test --coverage
```

### API Integration Testing

```bash
# استخدم Postman أو curl
curl -X GET http://localhost:3000/api/leagues \
  -H "Authorization: Bearer <token>"

# أو اختبر عبر Swagger
# http://localhost:3000/api/docs
```

---

## 📝 إضافة ميزة جديدة

### خطوات Backend

1. **أنشئ DTO (Data Transfer Object)**
   ```typescript
   // src/leagues/dto/create-league.dto.ts
   export class CreateLeagueDto {
     @IsString()
     @MinLength(3)
     name: string;

     @IsNumber()
     maxTeams: number;
   }
   ```

2. **سجل في Service**
   ```typescript
   // src/leagues/leagues.service.ts
   async createLeague(dto: CreateLeagueDto, user: User) {
     return this.prisma.league.create({
       data: {
         ...dto,
         organizerId: user.id,
       },
     });
   }
   ```

3. **أضف Endpoint في Controller**
   ```typescript
   // src/leagues/leagues.controller.ts
   @Post()
   @UseGuards(JwtAuthGuard, RolesGuard)
   @Roles('SUPER_ADMIN')
   async create(
     @Body() dto: CreateLeagueDto,
     @CurrentUser() user: User,
   ) {
     return this.leaguesService.createLeague(dto, user);
   }
   ```

4. **اكتب Unit Tests**
   ```typescript
   it('should create a league', async () => {
     // Test implementation
   });
   ```

### خطوات Frontend

1. **أنشئ Model**
   ```dart
   class LeagueModel {
     final String id;
     final String name;
     // ...
   }
   ```

2. **أنشئ Provider**
   ```dart
   final leagueProvider = FutureProvider.autoDispose<List<LeagueModel>>((ref) async {
     return ref.watch(apiClientProvider).getLeagues();
   });
   ```

3. **أنشئ Screen/Widget**
   ```dart
   class LeagueListScreen extends ConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       final leagues = ref.watch(leagueProvider);
       // UI implementation
     }
   }
   ```

---

## 🐛 إصلاح العيوب

### إبلاغ عن مشكلة

```markdown
## وصف المشكلة
وصف واضح للمشكلة

## خطوات التكرار
1. قم بـ ...
2. ثم ...
3. كانت النتيجة ...

## السلوك المتوقع
يجب أن يحدث ...

## بيئة النظام
- النظام: macOS/Windows/Linux
- الإصدار: ...
- المتصفح: ...

## لقطات الشاشة
[أضف لقطات إن أمكن]
```

### إصلاح العيب

```bash
# أنشئ فرع لإصلاح العيب
git checkout -b fix/issue-number-description

# اختبر الإصلاح محلياً
npm test
flutter test

# أرسل PR مع الإصلاح
git push origin fix/issue-number-description
```

---

## 📚 معايير التوثيق

### Code Comments
```typescript
// ✅ جيد - يشرح الـ Why والـ How
// Validate league name uniqueness before creation
// to prevent duplicate leagues in the same organization
if (await this.leagueExists(dto.name)) {
  throw new ConflictException('League already exists');
}

// ❌ سيء - واضح من الكود نفسه
// Check if league exists
if (await this.leagueExists(dto.name)) {
  throw new ConflictException('League already exists');
}
```

### JSDoc Comments
```typescript
/**
 * Creates a new league for the current user
 * 
 * @param {CreateLeagueDto} dto - League creation data
 * @param {User} user - Current authenticated user
 * @returns {Promise<League>} Created league
 * @throws {ConflictException} If league name already exists
 * 
 * @example
 * const league = await leaguesService.createLeague(
 *   { name: 'League 2026', maxTeams: 8 },
 *   currentUser
 * );
 */
async createLeague(dto: CreateLeagueDto, user: User): Promise<League> {
  // Implementation
}
```

---

## 🔄 مراجعة الأقران (Code Review)

### ما الذي نبحث عنه كمراجع
- ✅ الكود يتبع المعايير
- ✅ الاختبارات شاملة
- ✅ الأداء محسّنة
- ✅ لا توجد نقاط ضعف أمان
- ✅ التوثيق واضحة

### كيفية التعامل مع الملاحظات
- ✅ اسمع الملاحظات بانفتاح
- ✅ اسأل الأسئلة إن لم تفهم
- ✅ ناقش الخيارات المختلفة
- ✅ أجرِ التعديلات المطلوبة

---

## 📊 Branch Naming Convention

```
feature/    → new features
fix/        → bug fixes
docs/       → documentation
refactor/   → code refactoring
test/       → test additions
perf/       → performance improvements
chore/      → maintenance tasks
ci/         → CI/CD changes
```

**Examples:**
- `feature/player-statistics`
- `fix/jwt-token-expiration`
- `docs/api-endpoints`
- `refactor/league-service`

---

## 🚀 Deployment Checklist

قبل نشر النسخة الجديدة:

- [ ] جميع الاختبارات تمر locally
- [ ] لا توجد warning في الترجمة
- [ ] الأداء جيدة (لا توجد memory leaks)
- [ ] التوثيق محدثة
- [ ] CHANGELOG محدثة
- [ ] الإصدار تم ترقيمه (semantic versioning)
- [ ] تم اختبار على الأجهزة الفعلية/المحاكيات

---

## 📞 التواصل

- **Issues:** استخدم GitHub Issues للإبلاغ عن المشاكل
- **Discussions:** استخدم GitHub Discussions للأسئلة
- **Email:** [contact@league.com](mailto:contact@league.com)

---

## 📜 الترخيص

بمساهمتك، تقبل أن يتم توزيع عملك تحت نفس الترخيص: MIT License

---

## شكراً لك! 🙏

نقدّر مساهمتك للمشروع. معاً نبني نظام قوي وموثوق!

**Happy Coding! 💻🚀**

---

**آخر تحديث:** October 4, 2026
