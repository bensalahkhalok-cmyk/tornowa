# 🏗️ Architecture & Development Guide

## نظرة عامة على البنية

### الطبقات المعمارية (Layering)

```
┌─────────────────────────────────────┐
│      Presentation Layer (Flutter)   │ ← UI/UX لكل الأدوار
├─────────────────────────────────────┤
│      API Layer (NestJS Controllers)  │ ← REST Endpoints
├─────────────────────────────────────┤
│      Business Logic Layer (Services) │ ← Core Application Logic
├─────────────────────────────────────┤
│      Data Access Layer (Prisma)      │ ← Database Queries
├─────────────────────────────────────┤
│      Database Layer (PostgreSQL)     │ ← Persistent Storage
└─────────────────────────────────────┘
```

---

## 📁 هيكل المشروع الموصى به

### NestJS Backend Structure
```
src/
├── auth/                    # 🔐 Authentication Module
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   ├── auth.module.ts
│   ├── dto/
│   │   ├── register.dto.ts
│   │   ├── login.dto.ts
│   │   └── update-profile.dto.ts
│   ├── strategies/
│   │   └── jwt.strategy.ts
│   ├── guards/
│   │   ├── jwt-auth.guard.ts
│   │   └── roles.guard.ts
│   └── decorators/
│       ├── roles.decorator.ts
│       └── user.decorator.ts
│
├── leagues/                 # 🏆 Leagues Module
│   ├── leagues.controller.ts
│   ├── leagues.service.ts
│   ├── leagues.module.ts
│   └── dto/
│       ├── create-league.dto.ts
│       ├── update-league.dto.ts
│       └── league-invite.dto.ts
│
├── teams/                   # ⚽ Teams Module
│   ├── teams.controller.ts
│   ├── teams.service.ts
│   ├── teams.module.ts
│   └── dto/
│       ├── create-team.dto.ts
│       └── add-player.dto.ts
│
├── matches/                 # 🎯 Matches Module
│   ├── matches.controller.ts
│   ├── matches.service.ts
│   ├── matches.module.ts
│   └── dto/
│       ├── create-match.dto.ts
│       ├── update-score.dto.ts
│       └── match-event.dto.ts
│
├── notifications/           # 📢 Notifications (Optional)
│   ├── notifications.service.ts
│   └── notifications.gateway.ts
│
├── prisma/                  # 🗄️ Database Service
│   ├── prisma.module.ts
│   └── prisma.service.ts
│
├── common/                  # 🔧 Shared Utilities
│   ├── enums/
│   │   ├── roles.enum.ts
│   │   ├── match-status.enum.ts
│   │   └── league-status.enum.ts
│   ├── types/
│   │   ├── league.types.ts
│   │   └── team.types.ts
│   ├── filters/
│   │   └── http-exception.filter.ts
│   └── interceptors/
│       └── logging.interceptor.ts
│
├── config/                  # ⚙️ Configuration (Optional)
│   ├── database.config.ts
│   └── jwt.config.ts
│
├── app.module.ts            # Main Module
└── main.ts                  # Entry Point
```

### Flutter Frontend Structure
```
lib/
├── main.dart                # 🚀 App Entry Point
│
├── core/                    # 🔧 Core Services
│   ├── routes/
│   │   └── app_router.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│   ├── services/
│   │   ├── api_client.dart
│   │   ├── storage_service.dart
│   │   └── notification_service.dart
│   └── constants/
│       └── app_constants.dart
│
├── features/                # 🎯 Feature Modules
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── providers/
│   │   │       └── auth_provider.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_notifier.dart
│   │       └── screens/
│   │           ├── login_screen.dart
│   │           └── register_screen.dart
│   │
│   ├── leagues/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── league_model.dart
│   │   │   └── providers/
│   │   │       └── league_provider.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── league_detail_screen.dart
│   │       └── widgets/
│   │           └── league_card.dart
│   │
│   ├── teams/
│   │   └── ... (similar structure)
│   │
│   ├── matches/
│   │   └── ... (similar structure)
│   │
│   └── organizer/
│       ├── presentation/
│       │   └── screens/
│       │       └── organizer_dashboard.dart
│       └── ...
│
├── shared/                  # 🔄 Shared Components
│   ├── widgets/
│   │   ├── custom_app_bar.dart
│   │   ├── custom_button.dart
│   │   └── loading_indicator.dart
│   └── utils/
│       ├── validators.dart
│       └── formatters.dart
│
└── generated/               # Generated Code (Riverpod)
    └── ... (auto-generated)
```

---

## 🔄 Data Flow

### API Request Flow (Backend)

```
1. HTTP Request → API Endpoint (Controller)
             ↓
2. Validate Input (DTO + ValidationPipe)
             ↓
3. Check Authentication (JwtAuthGuard)
             ↓
4. Check Authorization (RolesGuard)
             ↓
5. Execute Business Logic (Service)
             ↓
6. Database Query (Prisma)
             ↓
7. Transform Response (Interceptor, Serialization)
             ↓
8. Return HTTP Response
```

### Example: Creating a League

```typescript
// 1. Controller receives request
@Post('/leagues')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('SUPER_ADMIN')
async createLeague(
  @Body() createLeagueDto: CreateLeagueDto,
  @CurrentUser() user: User,
) {
  return this.leaguesService.create(createLeagueDto, user);
}

// 2. Service contains business logic
async create(dto: CreateLeagueDto, organizer: User) {
  // Validate business rules
  if (await this.leagueExists(dto.name)) {
    throw new ConflictException('League already exists');
  }
  
  // Execute database operation
  const league = await this.prisma.league.create({
    data: {
      ...dto,
      organizerId: organizer.id,
    },
  });
  
  return league;
}

// 3. Prisma executes SQL
// INSERT INTO leagues (name, organizerId, ...) VALUES (...)

// 4. Response returned to Flutter app
// { id: '123', name: '...', organizerId: '...' }
```

---

## 🛡️ دعم القواعد والأدوار

### تسلسل الصلاحيات

```
SUPER_ADMIN (منظم/مسؤول)
    ├── إنشاء/تعديل/حذف الدوريات
    ├── إدارة الكباتنز
    ├── جدولة المباريات
    └── عرض جميع الإحصائيات
    
CAPTAIN (كابتن)
    ├── الانضمام للدوريات
    ├── إنشاء فريق
    ├── دعوة اللاعبين
    ├── تأكيد/رفض اللاعبين
    └── تحديث تشكيلة الفريق
    
PLAYER (لاعب)
    ├── الانضمام إلى الفريق
    ├── عرض المباريات
    ├── تأكيد الحضور
    ├── عرض الإحصائيات الشخصية
    └── تلقي الإشعارات
```

### تطبيق الأدوار في NestJS

```typescript
// Protect endpoint with role
@Post('/leagues')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('SUPER_ADMIN')
async createLeague(@Body() dto: CreateLeagueDto) {
  return this.leaguesService.create(dto);
}

// Multiple roles allowed
@Get('/my-leagues')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('SUPER_ADMIN', 'CAPTAIN')
async getMyLeagues(@CurrentUser() user: User) {
  return this.leaguesService.getUserLeagues(user.id);
}

// No role restriction
@Get('/public-leagues')
async getPublicLeagues() {
  return this.leaguesService.getAll();
}
```

---

## 📊 قاعدة البيانات - Best Practices

### Indexing Strategy
```prisma
model User {
  id    String  @id @default(cuid())
  email String  @unique @db.VarChar(255)  // Indexed for login
  phone String  @unique @db.VarChar(20)   // Indexed for phone lookup
  ...
  @@index([role])  // For role-based queries
}

model League {
  id          String  @id @default(cuid())
  organizerId String
  status      String  @default("DRAFT")
  ...
  @@index([organizerId])  // For organizer's leagues
  @@index([status])       // For filtering by status
}

model TeamMembership {
  ...
  @@index([teamId])
  @@index([playerId])
  @@index([teamId, playerId])  // For unique constraint
}
```

### Prisma Best Practices

```typescript
// ✅ Efficient queries
const league = await prisma.league.findUnique({
  where: { id },
  include: {
    teams: true,
    matches: true,
  },
});

// ✅ Filter and pagination
const leagues = await prisma.league.findMany({
  where: { status: 'ACTIVE' },
  include: { teams: true },
  skip: (page - 1) * limit,
  take: limit,
  orderBy: { createdAt: 'desc' },
});

// ❌ Avoid N+1 queries
// Bad:
const leagues = await prisma.league.findMany();
for (const league of leagues) {
  const teams = await prisma.team.findMany({
    where: { leagueId: league.id }
  }); // This runs for every league!
}

// Good:
const leagues = await prisma.league.findMany({
  include: { teams: true } // Single query
});
```

---

## 🧪 Testing

### Unit Tests Example (NestJS)

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { LeaguesService } from './leagues.service';
import { PrismaService } from '../prisma/prisma.service';

describe('LeaguesService', () => {
  let service: LeaguesService;
  let prisma: PrismaService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        LeaguesService,
        {
          provide: PrismaService,
          useValue: {
            league: {
              create: jest.fn(),
              findUnique: jest.fn(),
            },
          },
        },
      ],
    }).compile();

    service = module.get<LeaguesService>(LeaguesService);
    prisma = module.get<PrismaService>(PrismaService);
  });

  it('should create a league', async () => {
    const dto = { name: 'League 2026', maxTeams: 8 };
    const user = { id: 'user-1', role: 'SUPER_ADMIN' };
    
    jest.spyOn(prisma.league, 'create').mockResolvedValue({
      id: 'league-1',
      ...dto,
      organizerId: user.id,
      status: 'DRAFT',
    });
    
    const result = await service.create(dto, user);
    
    expect(result).toEqual({
      id: 'league-1',
      name: 'League 2026',
      organizerId: 'user-1',
    });
  });
});
```

---

## 🚀 Deployment

### Production Checklist

- [ ] Change JWT_SECRET to random strong key
- [ ] Set NODE_ENV=production
- [ ] Enable HTTPS
- [ ] Setup SSL certificates
- [ ] Configure environment variables
- [ ] Setup logs aggregation
- [ ] Configure database backup
- [ ] Setup CI/CD pipeline
- [ ] Add monitoring and alerts
- [ ] Setup database replication

### Docker Production Setup

```bash
# Build image
docker build -t league-api:1.0 .

# Run with production env
docker run -d \
  --name league-api \
  -e NODE_ENV=production \
  -e DATABASE_URL="postgresql://..." \
  -e JWT_SECRET="strong-random-key" \
  -p 3000:3000 \
  league-api:1.0
```

---

## 📱 Flutter Advanced Patterns

### Riverpod State Management (Advanced)

```dart
// Define state
class UserState {
  final User? user;
  final bool isLoading;
  final String? error;

  UserState({this.user, this.isLoading = false, this.error});
}

// Create provider
final authProvider = StateNotifierProvider<AuthNotifier, UserState>((ref) {
  return AuthNotifier(ref.watch(apiClientProvider));
});

// Notifier class
class AuthNotifier extends StateNotifier<UserState> {
  final ApiClient api;
  
  AuthNotifier(this.api) : super(UserState());
  
  Future<void> login(String email, String password) async {
    state = UserState(isLoading: true);
    try {
      final user = await api.login(email, password);
      state = UserState(user: user);
    } catch (e) {
      state = UserState(error: e.toString());
    }
  }
}

// Use in widget
Consumer(builder: (context, ref, child) {
  final authState = ref.watch(authProvider);
  
  if (authState.isLoading) return LoadingWidget();
  if (authState.error != null) return ErrorWidget(authState.error!);
  
  return DashboardWidget(user: authState.user!);
})
```

---

## 🔐 Security Best Practices

### Input Validation
```typescript
// DTO with validation
export class CreateLeagueDto {
  @IsString()
  @MinLength(3)
  @MaxLength(100)
  @Trim()
  name: string;

  @IsNumber()
  @Min(2)
  @Max(20)
  maxTeams: number;
}
```

### CORS Configuration
```typescript
app.enableCors({
  origin: process.env.CORS_ORIGIN?.split(','),
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
  credentials: true,
});
```

### Rate Limiting (Future)
```typescript
// Use @nestjs/throttler
@UseGuards(ThrottlerGuard)
@Throttle(10, 60) // 10 requests per minute
@Post('/auth/login')
login(@Body() dto: LoginDto) {
  // ...
}
```

---

## 📚 References
- [NestJS Documentation](https://docs.nestjs.com)
- [Prisma Guide](https://www.prisma.io/docs/)
- [Flutter Best Practices](https://flutter.dev/docs/perf/best-practices)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

**آخر تحديث:** October 4, 2026
