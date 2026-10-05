# 📚 API Documentation & Examples

## الـ Base URL
```
http://localhost:3000/api
```

## المصادقة (Authentication)

### تسجيل مستخدم جديد
```http
POST /auth/register
Content-Type: application/json

{
  "fullName": "أحمد محمد",
  "email": "ahmed@example.com",
  "phone": "+966501234567",
  "password": "StrongPassword123!",
  "role": "CAPTAIN"
}
```

**الرد (201 Created):**
```json
{
  "id": "user-uuid-here",
  "fullName": "أحمد محمد",
  "email": "ahmed@example.com",
  "phone": "+966501234567",
  "role": "CAPTAIN",
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer"
}
```

---

### تسجيل الدخول
```http
POST /auth/login
Content-Type: application/json

{
  "email": "ahmed@example.com",
  "password": "StrongPassword123!"
}
```

**الرد (200 OK):**
```json
{
  "id": "user-uuid-here",
  "fullName": "أحمد محمد",
  "email": "ahmed@example.com",
  "role": "CAPTAIN",
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer"
}
```

**استخدام الـ Token:**
```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

## الدوريات (Leagues)

### إنشاء دوري جديد (منظم فقط)
```http
POST /leagues
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "دوري القرية الصيفي 2026",
  "maxTeams": 8,
  "description": "دوري كرة قدم مصغر بين فرق القرية"
}
```

**الرد (201 Created):**
```json
{
  "id": "league-123",
  "name": "دوري القرية الصيفي 2026",
  "organizerId": "user-uuid",
  "maxTeams": 8,
  "status": "DRAFT",
  "createdAt": "2026-10-04T10:30:00Z",
  "updatedAt": "2026-10-04T10:30:00Z"
}
```

---

### احصل على جميع الدوريات
```http
GET /leagues
Authorization: Bearer <token>
```

**الرد (200 OK):**
```json
[
  {
    "id": "league-123",
    "name": "دوري القرية الصيفي 2026",
    "organizerId": "user-uuid",
    "maxTeams": 8,
    "status": "ACTIVE",
    "createdAt": "2026-10-04T10:30:00Z"
  },
  {
    "id": "league-456",
    "name": "دوري الشتاء 2026",
    "organizerId": "user-uuid",
    "maxTeams": 10,
    "status": "DRAFT",
    "createdAt": "2026-10-04T11:00:00Z"
  }
]
```

---

### احصل على دوري محدد
```http
GET /leagues/{leagueId}
Authorization: Bearer <token>
```

---

### تحديث الدوري
```http
PUT /leagues/{leagueId}
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "دوري القرية المحدّث",
  "maxTeams": 10
}
```

---

### حذف الدوري
```http
DELETE /leagues/{leagueId}
Authorization: Bearer <token>
```

---

## أكواد الدعوة (Invites)

### إنشاء كود دعوة (منظم فقط)
```http
POST /leagues/{leagueId}/generate-invite
Authorization: Bearer <token>
Content-Type: application/json

{
  "inviteType": "CAPTAIN",
  "expiresAt": "2026-10-15T23:59:59Z"
}
```

**الرد (201 Created):**
```json
{
  "id": "invite-123",
  "code": "LEAGUE2026CAPTAIN",
  "leagueId": "league-123",
  "inviteType": "CAPTAIN",
  "status": "ACTIVE",
  "expiresAt": "2026-10-15T23:59:59Z",
  "createdAt": "2026-10-04T10:30:00Z"
}
```

---

### استخدام كود الدعوة (كابتن/لاعب)
```http
POST /leagues/verify-invite
Authorization: Bearer <token>
Content-Type: application/json

{
  "code": "LEAGUE2026CAPTAIN"
}
```

**الرد (200 OK):**
```json
{
  "verified": true,
  "leagueId": "league-123",
  "leagueName": "دوري القرية الصيفي 2026",
  "inviteType": "CAPTAIN"
}
```

---

## الفرق (Teams)

### إنشاء فريق جديد (كابتن)
```http
POST /teams
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "فريق الشرقية",
  "leagueId": "league-123",
  "colors": "#FF0000",
  "description": "فريق قوي من منطقة الشرقية"
}
```

**الرد (201 Created):**
```json
{
  "id": "team-123",
  "name": "فريق الشرقية",
  "leagueId": "league-123",
  "captainId": "user-uuid",
  "colors": "#FF0000",
  "playerCount": 0,
  "createdAt": "2026-10-04T10:30:00Z"
}
```

---

### الحصول على فريق
```http
GET /teams/{teamId}
Authorization: Bearer <token>
```

**الرد (200 OK):**
```json
{
  "id": "team-123",
  "name": "فريق الشرقية",
  "leagueId": "league-123",
  "captainId": "user-uuid",
  "colors": "#FF0000",
  "playerCount": 11,
  "players": [
    {
      "id": "user-456",
      "fullName": "محمد علي",
      "position": "GK",
      "jerseyNumber": 1,
      "membershipStatus": "APPROVED"
    },
    {
      "id": "user-789",
      "fullName": "سارة أحمد",
      "position": "ST",
      "jerseyNumber": 9,
      "membershipStatus": "APPROVED"
    }
  ],
  "createdAt": "2026-10-04T10:30:00Z"
}
```

---

### إضافة لاعب إلى الفريق
```http
POST /teams/{teamId}/add-player
Authorization: Bearer <token>
Content-Type: application/json

{
  "playerId": "user-uuid",
  "position": "ST",
  "jerseyNumber": 9
}
```

**الرد (200 OK):**
```json
{
  "id": "membership-123",
  "teamId": "team-123",
  "playerId": "user-uuid",
  "position": "ST",
  "jerseyNumber": 9,
  "membershipStatus": "PENDING",
  "createdAt": "2026-10-04T10:30:00Z"
}
```

---

### قبول عضوية الفريق (لاعب)
```http
POST /teams/{teamId}/accept-membership
Authorization: Bearer <token>
```

**الرد (200 OK):**
```json
{
  "id": "membership-123",
  "teamId": "team-123",
  "playerId": "user-uuid",
  "membershipStatus": "APPROVED"
}
```

---

## المباريات (Matches)

### إنشاء مباراة جديدة (منظم)
```http
POST /matches
Authorization: Bearer <token>
Content-Type: application/json

{
  "leagueId": "league-123",
  "homeTeamId": "team-123",
  "awayTeamId": "team-456",
  "scheduledAt": "2026-10-10T18:00:00Z",
  "stadium": "ملعب المدينة الرياضي"
}
```

**الرد (201 Created):**
```json
{
  "id": "match-123",
  "leagueId": "league-123",
  "homeTeamId": "team-123",
  "awayTeamId": "team-456",
  "scheduledAt": "2026-10-10T18:00:00Z",
  "status": "SCHEDULED",
  "homeScore": 0,
  "awayScore": 0,
  "createdAt": "2026-10-04T10:30:00Z"
}
```

---

### احصل على جميع المباريات
```http
GET /matches?leagueId=league-123
Authorization: Bearer <token>
```

**الرد (200 OK):**
```json
[
  {
    "id": "match-123",
    "leagueId": "league-123",
    "homeTeam": {
      "id": "team-123",
      "name": "فريق الشرقية"
    },
    "awayTeam": {
      "id": "team-456",
      "name": "فريق الغربية"
    },
    "scheduledAt": "2026-10-10T18:00:00Z",
    "status": "SCHEDULED",
    "homeScore": 0,
    "awayScore": 0
  }
]
```

---

### تحديث نتيجة المباراة (منظم)
```http
PUT /matches/{matchId}
Authorization: Bearer <token>
Content-Type: application/json

{
  "status": "COMPLETED",
  "homeScore": 2,
  "awayScore": 1
}
```

**الرد (200 OK):**
```json
{
  "id": "match-123",
  "status": "COMPLETED",
  "homeScore": 2,
  "awayScore": 1,
  "updatedAt": "2026-10-10T20:30:00Z"
}
```

---

### تسجيل حدث في المباراة (منظم)
```http
POST /matches/{matchId}/events
Authorization: Bearer <token>
Content-Type: application/json

{
  "playerId": "user-123",
  "eventType": "GOAL",
  "minute": 45,
  "description": "هدف رأسي جميل"
}
```

**الرد (201 Created):**
```json
{
  "id": "event-123",
  "matchId": "match-123",
  "playerId": "user-123",
  "eventType": "GOAL",
  "minute": 45,
  "description": "هدف رأسي جميل",
  "createdAt": "2026-10-10T19:45:00Z"
}
```

---

## جدول الترتيب (Standings)

### احصل على جدول الترتيب
```http
GET /standings?leagueId=league-123
Authorization: Bearer <token>
```

**الرد (200 OK):**
```json
[
  {
    "id": "standing-1",
    "leagueId": "league-123",
    "teamId": "team-123",
    "teamName": "فريق الشرقية",
    "played": 5,
    "won": 4,
    "draw": 0,
    "lost": 1,
    "goalsFor": 12,
    "goalsAgainst": 5,
    "goalDifference": 7,
    "points": 12
  },
  {
    "id": "standing-2",
    "leagueId": "league-123",
    "teamId": "team-456",
    "teamName": "فريق الغربية",
    "played": 5,
    "won": 3,
    "draw": 1,
    "lost": 1,
    "goalsFor": 10,
    "goalsAgainst": 6,
    "goalDifference": 4,
    "points": 10
  }
]
```

---

## الملف الشخصي (Profile)

### احصل على ملف المستخدم
```http
GET /auth/profile
Authorization: Bearer <token>
```

**الرد (200 OK):**
```json
{
  "id": "user-uuid",
  "fullName": "أحمد محمد",
  "email": "ahmed@example.com",
  "phone": "+966501234567",
  "role": "CAPTAIN",
  "avatarUrl": "https://...",
  "createdAt": "2026-10-04T10:30:00Z"
}
```

---

### تحديث الملف الشخصي
```http
PUT /auth/profile
Authorization: Bearer <token>
Content-Type: application/json

{
  "fullName": "أحمد محمد علي",
  "avatarUrl": "https://example.com/avatar.jpg"
}
```

---

## أكواد الأخطاء الشائعة

| الكود | الوصف |
|------|-------|
| 200 | نجح ✅ |
| 201 | تم الإنشاء بنجاح ✅ |
| 400 | طلب خاطئ (validation error) ❌ |
| 401 | غير مصرح (missing/invalid token) 🔐 |
| 403 | ممنوع (insufficient permissions) 🚫 |
| 404 | غير موجود (resource not found) 🔍 |
| 409 | تضارب (duplicate email/phone) ⚠️ |
| 500 | خطأ خادم (server error) 💥 |

---

## أمثلة استخدام cURL

### تسجيل
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName":"Ahmed",
    "email":"ahmed@test.com",
    "phone":"+966501234567",
    "password":"pass123",
    "role":"CAPTAIN"
  }'
```

### تسجيل دخول
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email":"ahmed@test.com",
    "password":"pass123"
  }'
```

### إنشاء دوري (مع Token)
```bash
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

curl -X POST http://localhost:3000/api/leagues \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name":"League 2026",
    "maxTeams":8
  }'
```

---

## أمثلة استخدام Postman

1. **استيراد المجموعة:**
   - اذهب إلى Postman
   - انقر "Import"
   - استخدم الرابط: `http://localhost:3000/api/docs-json`

2. **إضافة الـ Token:**
   - اذهب إلى "Environments"
   - أنشئ متغير: `token = <your-jwt-token>`
   - استخدمه في الـ Authorization header: `Bearer {{token}}`

---

## ملاحظات أمان مهمة

✅ جميع المسارات بخلاف `/auth/register` و `/auth/login` تتطلب `Bearer Token`

✅ استخدم `@Roles('SUPER_ADMIN')` للمسارات الحساسة فقط

✅ لا تشاركل الـ JWT tokens مع أحد

✅ غيّر `JWT_SECRET` في الإنتاج إلى مفتاح قوي جداً

✅ استخدم HTTPS في الإنتاج (ليس HTTP)

---

**آخر تحديث:** October 4, 2026
