# Restaurant SaaS Backend

Core backend system for the restaurant SaaS platform. Handles review ingestion, AI-powered reply generation, email delivery, and competitive intelligence newsletters.

## 🏗️ Architecture

### Tech Stack
- **Runtime**: Node.js 20+ with TypeScript
- **Database**: PostgreSQL (Supabase compatible)
- **AI**: OpenAI GPT-4 Turbo
- **Email**: Resend
- **Deployment**: Railway / Render / GitHub Actions

### Core Components

1. **Database Layer** (`src/db/`)
   - Schema with 5 tables: restaurants, reviews, reply_drafts, newsletters, email_logs
   - Connection pool management
   - Migration utilities

2. **Services** (`src/services/`)
   - **Reply Generator**: GPT-4 powered reply drafting with tone profiles & escalation detection
   - **Email Service**: Resend integration with templated emails
   - **Newsletter Generator**: AI-driven competitive intelligence reports

3. **Jobs** (`src/jobs/`)
   - **Ingestion Job**: Polls Google/Yelp for new reviews every 4 hours
   - **Newsletter Job**: Generates weekly reports every Monday at 9am

## 📊 Database Schema

```sql
-- Core tables
restaurants          # Restaurant accounts
  - tone_profile_json: Brand voice configuration
  - competitors_json: Tracked competitors

reviews              # Ingested reviews (Google, Yelp, etc.)
  - Unique constraint on (platform, review_id) for deduplication

reply_drafts         # AI-generated draft replies
  - escalation_flag: Flags health/legal/discrimination issues
  - status: pending | approved | rejected | sent

newsletters          # Weekly competitive reports
  - content_json: Structured insights
  - content_html: Email-ready HTML

email_logs           # Audit trail for all emails
```

See `src/db/schema.sql` for full DDL.

## 🚀 Getting Started

### Prerequisites
- Node.js 20+
- PostgreSQL database (local or Supabase)
- OpenAI API key
- Resend API key

### 1. Clone & Install

```bash
cd ~/restaurant-saas/backend
npm install
```

### 2. Environment Setup

Copy `.env.example` to `.env` and fill in:

```bash
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/restaurant_saas

# OpenAI
OPENAI_API_KEY=sk-...

# Email
RESEND_API_KEY=re_...
FROM_EMAIL=noreply@yourdomain.com

# App
NODE_ENV=development
PORT=3000
```

### 3. Database Migration

```bash
npm run db:migrate
```

This creates all tables, indexes, and triggers.

### 4. Development

```bash
# Start dev server (auto-reload)
npm run dev

# Build for production
npm run build

# Run production
npm start
```

## 🔧 Running Jobs

### Ingestion Job

Polls review platforms and generates reply drafts.

```bash
# Manual run
npm run ingestion

# Or directly
tsx src/jobs/ingestion.ts
```

**Schedule**: Every 4 hours

### Newsletter Job

Generates weekly competitive intelligence reports.

```bash
# Manual run (current week)
npm run newsletter

# Or for specific week
tsx src/jobs/newsletter.ts 2024-02-05
```

**Schedule**: Every Monday at 9:00 AM

## 📅 Deployment & Scheduling

### Option 1: Railway (Recommended)

Railway supports native cron jobs. The `railway.json` config is already set up:

```json
{
  "cron": [
    {
      "name": "ingestion",
      "schedule": "0 */4 * * *",
      "command": "node dist/jobs/ingestion.js"
    },
    {
      "name": "newsletter",
      "schedule": "0 9 * * 1",
      "command": "node dist/jobs/newsletter.js"
    }
  ]
}
```

**Deploy**:
```bash
# Install Railway CLI
npm i -g @railway/cli

# Login & deploy
railway login
railway up
```

Add environment variables in Railway dashboard.

### Option 2: GitHub Actions

Workflows are in `.github/workflows/`:
- `ingestion-cron.yml` - Every 4 hours
- `newsletter-cron.yml` - Monday 9am

**Setup**:
1. Push to GitHub
2. Add secrets: `DATABASE_URL`, `OPENAI_API_KEY`, `RESEND_API_KEY`, `FROM_EMAIL`
3. Jobs run automatically on schedule

**Manual trigger**: Actions tab → Select workflow → "Run workflow"

### Option 3: Render

Render supports cron jobs via `render.yaml`:

```yaml
services:
  - type: cron
    name: ingestion-job
    env: node
    schedule: "0 */4 * * *"
    buildCommand: npm install && npm run build
    startCommand: node dist/jobs/ingestion.js

  - type: cron
    name: newsletter-job
    env: node
    schedule: "0 9 * * 1"
    buildCommand: npm install && npm run build
    startCommand: node dist/jobs/newsletter.js
```

## 🤖 AI Reply Generation

### Features
- **Tone Profiles**: Customize voice per restaurant (professional, friendly, casual)
- **Escalation Detection**: Auto-flags health issues, threats, discrimination, refund requests
- **Multi-Option Drafts**: Generates 2 different reply approaches
- **Platform-Aware**: Adjusts style for Google, Yelp, etc.

### Configuration Example

```typescript
const toneProfile = {
  tone: "friendly",
  personality: ["warm", "authentic", "locally-focused"],
  avoid: ["corporate jargon", "excessive emojis"],
  emphasis: ["community", "quality ingredients"],
  signature: "Hope to see you again soon! - The Team"
};
```

### Escalation Triggers
- `health_issue`: Food poisoning, illness, contamination
- `threat`: Legal threats, violence
- `discrimination`: Racist, sexist, discriminatory language
- `refund_request`: Money back, chargeback
- `legal_concern`: Violations, regulations
- `extreme_negativity`: Severe complaints

Escalated reviews generate conservative replies and notify owners.

## 📧 Email System

### Reply Draft Email
- Shows original review with rating & platform
- Displays AI-generated reply options
- Escalation alerts for sensitive issues
- One-click links to respond on platform
- Tracked in `email_logs` table

### Newsletter Email
- Competitor moves & insights
- Review trend analysis
- Pricing signals
- Actionable recommendations
- Beautiful HTML template with priority levels

## 🔄 Review Ingestion (Placeholder)

The ingestion pipeline is **waiting for data-api-agent** to provide the review fetching specification.

Current structure:
```typescript
interface ReviewSource {
  platform: 'google' | 'yelp';
  fetchReviews(restaurantId: string, since?: Date): Promise<Review[]>;
}
```

Once data-api-agent provides Google/Yelp API integrations, register them:

```typescript
import { googleReviewSource } from '../sources/google.js';
import { yelpReviewSource } from '../sources/yelp.js';

ingestionJob.registerSource(googleReviewSource);
ingestionJob.registerSource(yelpReviewSource);
```

**Deduplication**: Uses `(platform, review_id)` unique constraint to prevent reprocessing.

## 🧪 Testing

### Health Check
```bash
curl http://localhost:3000/health
```

### Manual Job Triggers
```bash
# Trigger ingestion
curl -X POST http://localhost:3000/jobs/ingestion/run

# Trigger newsletter
curl -X POST http://localhost:3000/jobs/newsletter/run
```

### Test Data Insertion

```sql
-- Create test restaurant
INSERT INTO restaurants (name, location, owner_email, tone_profile_json, competitors_json)
VALUES (
  'Pizza Paradise',
  'Brooklyn, NY',
  'owner@pizzaparadise.com',
  '{"tone": "friendly", "personality": ["warm", "family-oriented"]}',
  '[{"name": "Joe''s Pizza", "platform": "google", "id": "123"}]'
);

-- Insert test review
INSERT INTO reviews (restaurant_id, platform, review_id, author, rating, text, review_date)
VALUES (
  '<restaurant_id>',
  'google',
  'test-review-001',
  'John Doe',
  5,
  'Amazing pizza! Best in Brooklyn. The crust is perfect and the sauce is incredible.',
  NOW() - INTERVAL '1 day'
);
```

Then run jobs to process.

## 📈 Monitoring

### Database Queries
```sql
-- Review ingestion stats
SELECT platform, COUNT(*), AVG(rating)
FROM reviews
WHERE ingested_at > NOW() - INTERVAL '7 days'
GROUP BY platform;

-- Escalation rate
SELECT 
  COUNT(*) as total_drafts,
  SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END) as escalated,
  ROUND(100.0 * SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END) / COUNT(*), 2) as escalation_rate
FROM reply_drafts
WHERE created_at > NOW() - INTERVAL '30 days';

-- Email delivery stats
SELECT type, status, COUNT(*)
FROM email_logs
WHERE created_at > NOW() - INTERVAL '7 days'
GROUP BY type, status;
```

### Logs
```bash
# Railway
railway logs

# GitHub Actions
Check workflow run logs in Actions tab
```

## 🔐 Security Notes

- Never commit `.env` file
- Use environment variables for all secrets
- Database uses SSL in production
- Email logs track all outbound communications
- Escalation flags prevent auto-responses to sensitive issues

## 📝 Project Status

### ✅ Complete
- [x] Database schema with migrations
- [x] Reply generation service (GPT-4 + escalation detection)
- [x] Email delivery service (Resend integration)
- [x] Newsletter generation service
- [x] Scheduler configurations (Railway, GitHub Actions)
- [x] Email templates & HTML rendering
- [x] Deduplication logic
- [x] Error handling & logging

### ⏳ Pending
- [ ] Review ingestion API integrations (waiting for data-api-agent)
- [ ] Platform-specific review URLs
- [ ] Admin API endpoints
- [ ] Webhook support for real-time ingestion
- [ ] Reply approval workflow (frontend)

## 🤝 Integration Points

### With Data API Agent
Expecting:
```typescript
interface ReviewFetcher {
  fetchGoogleReviews(placeId: string, since?: Date): Promise<Review[]>;
  fetchYelpReviews(businessId: string, since?: Date): Promise<Review[]>;
}
```

### With Frontend (Future)
- Dashboard to view/approve drafts
- Restaurant onboarding & configuration
- Analytics & reporting
- Manual reply editing

## 📚 File Structure

```
backend/
├── src/
│   ├── db/
│   │   ├── schema.sql          # Database DDL
│   │   ├── client.ts           # Connection pool
│   │   └── migrate.ts          # Migration runner
│   ├── services/
│   │   ├── replyGenerator.ts   # GPT-4 reply drafting
│   │   ├── emailService.ts     # Resend email sending
│   │   └── newsletterGenerator.ts  # Weekly reports
│   ├── jobs/
│   │   ├── ingestion.ts        # Review polling job
│   │   └── newsletter.ts       # Weekly newsletter job
│   ├── types/
│   │   └── models.ts           # TypeScript interfaces
│   ├── utils/
│   │   └── logger.ts           # Logging utility
│   └── index.ts                # HTTP server
├── .github/workflows/          # GitHub Actions cron
├── .env.example                # Environment template
├── railway.json                # Railway config
├── tsconfig.json               # TypeScript config
├── package.json
└── README.md                   # This file
```

## 🆘 Troubleshooting

### Database Connection Issues
```bash
# Test connection
psql $DATABASE_URL -c "SELECT 1"

# Check migration
npm run db:migrate
```

### OpenAI Rate Limits
- GPT-4 Turbo has rate limits (10,000 TPM on tier 1)
- Batch requests with delays if hitting limits
- Monitor usage in OpenAI dashboard

### Email Delivery Failures
- Check Resend dashboard for bounce/spam reports
- Verify FROM_EMAIL domain is verified in Resend
- Check `email_logs` table for error messages

### Job Not Running
- Check scheduler logs (Railway/GitHub Actions)
- Verify environment variables are set
- Test manual run first: `npm run ingestion`

## 📞 Support

For issues or questions:
1. Check logs: `railway logs` or GitHub Actions output
2. Review database: Query `email_logs` and `reply_drafts` tables
3. Test manually: Run jobs directly with `tsx`

---

**Built by**: Backend Engineer Agent  
**Last Updated**: 2026-02-10  
**Version**: 1.0.0
