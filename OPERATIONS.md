# OPERATIONS.md
## Restaurant SaaS - Operational Runbook & QA Procedures

**Last Updated:** 2026-02-10  
**Owner:** QA/Operations Team  
**Purpose:** Complete operational guide for pilot program success

---

## TABLE OF CONTENTS

1. [Pilot Onboarding Checklist](#1-pilot-onboarding-checklist)
2. [Operational Runbook](#2-operational-runbook)
3. [Monitoring Dashboard](#3-monitoring-dashboard)
4. [Quality Assurance](#4-quality-assurance)
5. [Pilot Success Metrics](#5-pilot-success-metrics)
6. [Emergency Contacts & Escalation](#6-emergency-contacts--escalation)

---

## 1. PILOT ONBOARDING CHECKLIST

### 1.1 Pre-Onboarding (T-3 days)

**Information Collection (Intake Form)**

Create a Google Form or Typeform with these required fields:

```
RESTAURANT INFORMATION:
□ Restaurant Legal Name: _______________
□ DBA (Doing Business As): _______________
□ Primary Contact Name: _______________
□ Primary Contact Email: _______________
□ Primary Contact Phone: _______________
□ Restaurant Address: _______________
□ Website URL: _______________
□ Google Business Profile URL: _______________

REVIEW PLATFORMS:
□ Google Business Profile ID: _______________
□ Yelp Business URL: _______________
□ TripAdvisor URL: _______________
□ OpenTable URL (if applicable): _______________

BRAND VOICE & TONE:
□ Preferred Response Tone (select all):
  ☐ Professional  ☐ Friendly  ☐ Casual  ☐ Warm  ☐ Formal
□ Brand Personality Keywords (3-5 words): _______________
□ Words/Phrases to Always Include: _______________
□ Words/Phrases to Avoid: _______________
□ Example Response (optional - paste a past reply you liked): _______________

COMPETITOR INTELLIGENCE:
□ Competitor 1 Name & Google URL: _______________
□ Competitor 2 Name & Google URL: _______________
□ Competitor 3 Name & Google URL: _______________

EMAIL CONFIGURATION:
□ Sender Name (e.g., "Maria at Bella Pasta"): _______________
□ Reply-To Email (verified domain): _______________
□ Newsletter Day Preference: 
  ☐ Monday  ☐ Tuesday  ☐ Wednesday  ☐ Thursday  ☐ Friday
□ Newsletter Time Preference: 
  ☐ 8am  ☐ 9am  ☐ 10am  ☐ 12pm  ☐ 2pm

OPERATIONAL PREFERENCES:
□ Reply Approval Required? ☐ Yes  ☐ No (auto-send)
□ Newsletter Frequency: ☐ Weekly  ☐ Bi-weekly  ☐ Monthly
□ Minimum Review Rating to Reply: ☐ All  ☐ 1-3 stars only  ☐ 4-5 stars only
```

**Pre-Flight Checks:**
- [ ] Verify email domain is validated in Resend
- [ ] Confirm Google Business API access works
- [ ] Check Supabase database has capacity
- [ ] Ensure OpenAI API credits are sufficient

### 1.2 Account Setup (Day 0)

**Database Configuration:**

```sql
-- Insert restaurant record
INSERT INTO restaurants (
  name,
  slug,
  contact_email,
  website,
  google_place_id,
  yelp_url,
  tripadvisor_url,
  status
) VALUES (
  'Restaurant Name',
  'restaurant-slug',
  'contact@restaurant.com',
  'https://restaurant.com',
  'ChIJ...',
  'https://yelp.com/biz/...',
  'https://tripadvisor.com/...',
  'active'
) RETURNING id;

-- Configure brand voice
INSERT INTO restaurant_settings (
  restaurant_id,
  tone_keywords,
  avoid_phrases,
  signature_phrases,
  response_style
) VALUES (
  <restaurant_id>,
  '{"friendly","welcoming","authentic"}',
  '{"no problem","guys"}',
  '{"Hope to see you again soon!"}',
  'warm_professional'
);

-- Add competitors
INSERT INTO competitors (restaurant_id, name, google_place_id, priority)
VALUES 
  (<restaurant_id>, 'Competitor A', 'ChIJ...', 1),
  (<restaurant_id>, 'Competitor B', 'ChIJ...', 2),
  (<restaurant_id>, 'Competitor C', 'ChIJ...', 3);

-- Email configuration
INSERT INTO email_config (
  restaurant_id,
  sender_name,
  reply_to_email,
  newsletter_day,
  newsletter_time,
  requires_approval
) VALUES (
  <restaurant_id>,
  'Maria at Bella Pasta',
  'maria@bellapasta.com',
  'monday',
  '09:00:00',
  true
);
```

**Validation Steps:**
- [ ] Run test query: `SELECT * FROM restaurants WHERE id = <restaurant_id>;`
- [ ] Verify all settings saved correctly
- [ ] Check foreign key relationships

### 1.3 Pre-Launch Testing (T-1 day)

**Test Checklist:**

1. **Review Ingestion Test**
```bash
# Run manual ingestion for this restaurant
npm run ingestion -- --restaurant-id=<id> --dry-run

# Verify:
□ Reviews fetched successfully
□ Review data parsed correctly (rating, text, date, author)
□ No duplicate reviews created
□ Error handling works (invalid credentials, rate limits)
```

2. **Reply Generation Test**
```bash
# Generate test reply for a sample review
curl -X POST http://localhost:3000/api/reviews/generate-reply \
  -H "Content-Type: application/json" \
  -d '{
    "restaurant_id": "<id>",
    "review_text": "Great food but slow service",
    "rating": 4,
    "reviewer_name": "John D."
  }'

# Verify:
□ Reply matches brand voice
□ Personalization includes reviewer name
□ Tone appropriate for rating (4-5 stars = grateful, 1-3 = apologetic)
□ Length is 50-150 words
□ No generic templates ("Thank you for your feedback")
```

3. **Email Deliverability Test**
```bash
# Send test welcome email
npm run test:email -- --restaurant-id=<id> --type=welcome

# Check:
□ Email arrives within 60 seconds
□ Sender name displays correctly
□ Reply-to address is correct
□ No spam folder placement
□ Images load (if any)
□ Links work
□ Unsubscribe link functions
```

4. **Newsletter Generation Test**
```bash
# Generate test newsletter with mock data
npm run newsletter -- --restaurant-id=<id> --dry-run

# Verify:
□ Review summary includes all reviews from past week
□ Competitor insights are accurate
□ Sentiment analysis is reasonable
□ Formatting is clean (no broken HTML)
□ Charts/data visualizations render
□ Call-to-action is clear
```

5. **Edge Case Testing**
- [ ] No reviews this week → Newsletter should say "No new reviews" gracefully
- [ ] All 5-star reviews → Celebratory tone
- [ ] All 1-star reviews → Supportive, action-oriented tone
- [ ] Competitor has no data → Omit competitor section, don't show errors
- [ ] Special characters in review text → Properly escaped
- [ ] Very long review (>500 words) → Summarized correctly

**Pre-Launch Sign-Off:**
- [ ] All tests passed
- [ ] Restaurant owner reviewed sample reply
- [ ] Newsletter preview approved
- [ ] Email deliverability confirmed
- [ ] Monitoring alerts configured

### 1.4 Communication Plan

**Welcome Email (Day 0 - Immediately after setup)**

Subject: Welcome to [SaaS Name]! Your Account is Ready 🎉

```
Hi [Contact Name],

Welcome aboard! Your account is set up and ready to go.

What happens next:
✅ Daily: We'll monitor your reviews across Google, Yelp, and TripAdvisor
✅ [Newsletter Day]: You'll receive your weekly insights newsletter
✅ When new reviews arrive: We'll generate personalized draft replies

Your Dashboard: https://app.restaurantsaas.com/login?email=[email]
(Password reset link included)

Quick Start Guide:
1. Review your brand voice settings (Settings > Brand Voice)
2. Approve or edit your first draft reply
3. Check your competitor tracking setup

Questions? Reply to this email or book a 15-min training call: [calendly-link]

Excited to help you manage your online reputation!

[Your Name]
[SaaS Name] Team
```

**Training Call (Day 1-2)**

30-minute Zoom covering:
- [ ] Dashboard walkthrough (5 min)
- [ ] How to approve/edit replies (5 min)
- [ ] Newsletter breakdown (5 min)
- [ ] Tone customization (5 min)
- [ ] Q&A (10 min)

**Check-In Schedule:**
- **Week 1 (Day 3):** "How's it going?" email - collect initial feedback
- **Week 1 (Day 7):** First newsletter sent - follow up to confirm receipt
- **Week 2 (Day 14):** Health check call - review metrics, adjust settings
- **Week 4 (Day 28):** Pilot review - discuss conversion to paid plan

**Check-In Email Template (Day 3):**

Subject: Quick check-in on your first week

```
Hi [Name],

Just wanted to check in on your first few days with [SaaS Name].

Quick pulse check:
- Have you received any draft replies yet? How did they sound?
- Any reviews we missed or settings you'd like to tweak?
- Newsletter arriving at the right time?

No need for a long response - even a quick "all good!" or "let's chat" helps.

[Your Name]
```

---

## 2. OPERATIONAL RUNBOOK

### 2.1 Daily Monitoring Checklist

**Morning Routine (09:00 - 09:30 AM EST)**

Run this daily health check query:

```sql
-- Daily Health Dashboard
SELECT 
  'Ingestion Status' as check_type,
  COUNT(*) as total_restaurants,
  COUNT(CASE WHEN last_ingestion_at > NOW() - INTERVAL '24 hours' THEN 1 END) as successful_24h,
  COUNT(CASE WHEN last_ingestion_error IS NOT NULL THEN 1 END) as with_errors
FROM restaurants WHERE status = 'active'

UNION ALL

SELECT 
  'Email Delivery' as check_type,
  COUNT(*) as total_sent,
  COUNT(CASE WHEN status = 'delivered' THEN 1 END) as delivered,
  COUNT(CASE WHEN status = 'bounced' OR status = 'failed' THEN 1 END) as failed
FROM email_logs WHERE created_at > NOW() - INTERVAL '24 hours'

UNION ALL

SELECT 
  'Pending Approvals' as check_type,
  COUNT(*) as total,
  COUNT(CASE WHEN created_at < NOW() - INTERVAL '48 hours' THEN 1 END) as overdue,
  NULL
FROM draft_replies WHERE status = 'pending_approval'

UNION ALL

SELECT 
  'Job Failures' as check_type,
  COUNT(*) as total,
  COUNT(CASE WHEN error_type = 'rate_limit' THEN 1 END) as rate_limits,
  COUNT(CASE WHEN error_type = 'api_error' THEN 1 END) as api_errors
FROM job_logs WHERE created_at > NOW() - INTERVAL '24 hours' AND status = 'failed';
```

**Red Flags (Immediate Action Required):**
- ❌ Any restaurant with no ingestion in 24h
- ❌ Email bounce rate > 5%
- ❌ More than 3 job failures for same restaurant
- ❌ OpenAI API errors (quota/auth issues)

**Yellow Flags (Investigate Today):**
- ⚠️ Draft replies pending > 48 hours
- ⚠️ Newsletter not sent on scheduled day
- ⚠️ Competitor data missing for active restaurants
- ⚠️ Slow API response times (>5s for review fetch)

**Green Flags (All Good):**
- ✅ All restaurants ingested in last 24h
- ✅ Email delivery rate > 95%
- ✅ No job failures
- ✅ Draft replies generated within 1 hour of new review

### 2.2 Failed Job Recovery

#### Scenario: Review Ingestion Failed

**Diagnosis:**

```sql
-- Check ingestion errors
SELECT 
  r.name,
  r.last_ingestion_at,
  r.last_ingestion_error,
  jl.error_details,
  jl.created_at
FROM restaurants r
LEFT JOIN job_logs jl ON jl.restaurant_id = r.id AND jl.job_type = 'ingestion'
WHERE r.last_ingestion_error IS NOT NULL
ORDER BY jl.created_at DESC;
```

**Common Errors & Fixes:**

| Error | Cause | Fix |
|-------|-------|-----|
| `RATE_LIMIT_EXCEEDED` | Google API quota hit | Wait 1 hour, then retry. Consider distributing ingestion across day |
| `INVALID_CREDENTIALS` | Google API key expired | Regenerate API key in Google Cloud Console, update `.env` |
| `PLACE_NOT_FOUND` | Incorrect Google Place ID | Verify Place ID, update in database |
| `NETWORK_TIMEOUT` | API unresponsive | Retry with exponential backoff (built into code) |
| `PARSING_ERROR` | Unexpected review format | Check logs for malformed data, update parser |

**Manual Recovery Steps:**

```bash
# 1. Retry single restaurant
npm run ingestion -- --restaurant-id=<id> --force

# 2. If still failing, enable debug mode
DEBUG=* npm run ingestion -- --restaurant-id=<id>

# 3. Check API credentials
curl "https://maps.googleapis.com/maps/api/place/details/json?place_id=<id>&key=$GOOGLE_API_KEY"

# 4. If Google API is down, check status
curl https://status.cloud.google.com/

# 5. Last resort: skip this cycle, schedule retry in 6 hours
psql -d $DATABASE_URL -c "UPDATE restaurants SET last_ingestion_at = NOW() WHERE id = <id>;"
# Then set reminder to retry manually
```

#### Scenario: Email Bounced / Failed

**Diagnosis:**

```sql
-- Check email failures
SELECT 
  el.email_to,
  el.subject,
  el.status,
  el.error_message,
  el.bounce_type,
  el.created_at
FROM email_logs el
WHERE el.status IN ('bounced', 'failed')
  AND el.created_at > NOW() - INTERVAL '7 days'
ORDER BY el.created_at DESC;
```

**Bounce Types & Actions:**

| Bounce Type | Meaning | Action |
|-------------|---------|--------|
| `hard_bounce` | Email doesn't exist | Mark email invalid, contact restaurant for new address |
| `soft_bounce` | Temporary issue (full inbox) | Retry in 4 hours, if fails 3x treat as hard bounce |
| `spam_complaint` | Recipient marked as spam | Immediately unsubscribe, investigate content |
| `invalid_domain` | Domain doesn't exist | Contact restaurant for correct email |

**Recovery Process:**

```bash
# 1. Check Resend dashboard for detailed error
# https://resend.com/emails

# 2. For soft bounces, retry manually
npm run email:retry -- --email-log-id=<id>

# 3. For hard bounces, mark email as invalid
psql -d $DATABASE_URL -c "
  UPDATE restaurants 
  SET contact_email_status = 'invalid',
      contact_email_verified_at = NULL
  WHERE contact_email = '<bounced-email>';
"

# 4. Send SMS or call restaurant to get new email
# 5. Verify new email with double opt-in
```

**Email Verification Script:**

```bash
# Send verification email
npm run email:verify -- --restaurant-id=<id> --email=<new-email>

# Wait for click, then:
psql -d $DATABASE_URL -c "
  UPDATE restaurants 
  SET contact_email = '<new-email>',
      contact_email_status = 'verified',
      contact_email_verified_at = NOW()
  WHERE id = <id>;
"
```

#### Scenario: Newsletter Generation Failed

**Diagnosis:**

```sql
-- Check newsletter generation logs
SELECT 
  r.name,
  nl.scheduled_for,
  nl.status,
  nl.error_message,
  nl.generated_at,
  nl.sent_at
FROM newsletters nl
JOIN restaurants r ON r.id = nl.restaurant_id
WHERE nl.status = 'failed'
ORDER BY nl.scheduled_for DESC;
```

**Common Issues:**

1. **No reviews this week** (Not actually an error)
   - Generate newsletter anyway with "No new reviews" message
   - Include competitor insights only
   - Prompt: "Great week to focus on service!"

2. **OpenAI API error**
   - Check quota: `curl https://api.openai.com/v1/usage`
   - Retry with different model (gpt-3.5-turbo as fallback)
   - If quota exhausted, send manual summary instead

3. **Competitor data missing**
   - Check if competitor ingestion ran
   - If failed, run manually: `npm run ingestion:competitors -- --restaurant-id=<id>`
   - Send newsletter without competitor section if urgent

**Manual Newsletter Send:**

```bash
# 1. Regenerate newsletter
npm run newsletter:generate -- --restaurant-id=<id> --week=2026-02-03

# 2. Preview HTML
npm run newsletter:preview -- --newsletter-id=<id>
# Opens in browser

# 3. If looks good, send
npm run newsletter:send -- --newsletter-id=<id>

# 4. Verify delivery
psql -d $DATABASE_URL -c "SELECT * FROM email_logs WHERE newsletter_id = <id>;"
```

### 2.3 Manual Override Procedures

#### Override 1: Skip Auto-Reply for Specific Review

Sometimes a review needs human touch (legal threat, serious issue, VIP customer).

```sql
-- Mark review as "manual_reply_required"
UPDATE reviews 
SET requires_manual_reply = true,
    auto_reply_enabled = false
WHERE id = <review_id>;

-- Notify restaurant owner
INSERT INTO notifications (restaurant_id, type, message)
VALUES (<restaurant_id>, 'manual_reply_required', 'Review flagged for manual response');
```

Then email the restaurant with context.

#### Override 2: Emergency Pause All Automation

If something is broken, pause everything:

```sql
-- Pause all restaurants
UPDATE restaurants SET status = 'paused' WHERE status = 'active';

-- Or pause specific restaurant
UPDATE restaurants SET status = 'paused' WHERE id = <id>;
```

```bash
# Stop cron jobs
crontab -e
# Comment out lines, save

# Verify no jobs running
ps aux | grep "npm run"
pkill -f "npm run ingestion"
pkill -f "npm run newsletter"
```

To resume:
```sql
UPDATE restaurants SET status = 'active' WHERE status = 'paused';
```

#### Override 3: Resend Newsletter

If newsletter had wrong data or didn't send:

```bash
# 1. Mark previous as cancelled
psql -d $DATABASE_URL -c "
  UPDATE newsletters 
  SET status = 'cancelled' 
  WHERE id = <newsletter_id>;
"

# 2. Generate fresh newsletter
npm run newsletter:generate -- --restaurant-id=<id> --force

# 3. Send immediately (bypass schedule)
npm run newsletter:send -- --newsletter-id=<new_id> --force
```

#### Override 4: Bulk Reply Approval

If a restaurant is on vacation and wants to approve all pending:

```sql
-- Preview drafts
SELECT id, review_text, draft_reply_text 
FROM draft_replies 
WHERE restaurant_id = <id> AND status = 'pending_approval';

-- If all look good, approve all
UPDATE draft_replies 
SET status = 'approved', approved_at = NOW() 
WHERE restaurant_id = <id> AND status = 'pending_approval';

-- Trigger actual posting
npm run replies:post -- --restaurant-id=<id>
```

### 2.4 Customer Support Scenarios

#### "I didn't receive my newsletter"

**Troubleshooting Steps:**

1. Check if it was sent:
```sql
SELECT * FROM newsletters 
WHERE restaurant_id = <id> 
ORDER BY scheduled_for DESC LIMIT 1;
```

2. Check email logs:
```sql
SELECT * FROM email_logs 
WHERE newsletter_id = <newsletter_id>;
```

3. Possible causes:
   - Landed in spam folder → Ask them to check, whitelist sender
   - Wrong email address → Verify in settings
   - Bounced → Check bounce reason
   - Not scheduled for that day → Check newsletter_day setting

4. Resolution:
```bash
# Resend newsletter
npm run newsletter:send -- --newsletter-id=<id> --recipient-override=<their-email>
```

#### "The reply doesn't sound like me"

**Process:**

1. Review their brand voice settings:
```sql
SELECT tone_keywords, avoid_phrases, signature_phrases, response_style 
FROM restaurant_settings 
WHERE restaurant_id = <id>;
```

2. Ask for specific feedback:
   - "Too formal / casual?"
   - "Missing personality?"
   - "Wrong words used?"

3. Update settings:
```sql
UPDATE restaurant_settings 
SET tone_keywords = '{"warm","authentic","family-owned"}',
    signature_phrases = '{"We can''t wait to serve you again!"}',
    response_style = 'friendly_casual'
WHERE restaurant_id = <id>;
```

4. Regenerate reply with new settings:
```bash
npm run replies:regenerate -- --draft-id=<id>
```

5. Follow up: "How's this version?"

#### "I want to change my newsletter day/time"

```sql
UPDATE email_config 
SET newsletter_day = 'wednesday',
    newsletter_time = '14:00:00'
WHERE restaurant_id = <id>;
```

Then confirm: "Updated! Next newsletter: Wednesday, Feb 14 at 2:00 PM"

#### "How do I stop tracking a competitor?"

```sql
-- Soft delete (preserves historical data)
UPDATE competitors 
SET active = false 
WHERE id = <competitor_id>;

-- Or hard delete
DELETE FROM competitors WHERE id = <competitor_id>;
```

#### "I got a review but didn't get a draft reply"

**Diagnosis:**

1. Check if review was ingested:
```sql
SELECT * FROM reviews 
WHERE restaurant_id = <id> 
ORDER BY review_date DESC LIMIT 10;
```

2. If not there:
   - Manual ingestion: `npm run ingestion -- --restaurant-id=<id> --force`
   
3. If ingested but no draft:
```sql
SELECT * FROM draft_replies WHERE review_id = <review_id>;
```

4. Check error logs:
```sql
SELECT * FROM job_logs 
WHERE restaurant_id = <id> AND job_type = 'reply_generation' 
ORDER BY created_at DESC LIMIT 5;
```

5. Common causes:
   - Reply generation disabled for that rating tier
   - OpenAI API error → Retry
   - Review marked as "no reply needed" → Override

#### "Can I cancel / get a refund?"

**Process:**

1. Mark in database:
```sql
UPDATE restaurants 
SET status = 'cancelled',
    cancellation_date = NOW(),
    cancellation_reason = '<reason>'
WHERE id = <id>;
```

2. Stop all jobs:
```sql
UPDATE email_config SET active = false WHERE restaurant_id = <id>;
```

3. Export their data (GDPR):
```bash
npm run export:restaurant-data -- --restaurant-id=<id> --output=/tmp/export.json
```

4. Send export + confirm cancellation:
   - "Account cancelled. Here's your data export. Hope to work together again!"

---

## 3. MONITORING DASHBOARD

### 3.1 Supabase SQL Queries

**Create monitoring views:**

```sql
-- View: Daily Health Overview
CREATE OR REPLACE VIEW v_daily_health AS
SELECT 
  DATE(NOW()) as check_date,
  (SELECT COUNT(*) FROM restaurants WHERE status = 'active') as active_restaurants,
  (SELECT COUNT(*) FROM restaurants WHERE status = 'active' AND last_ingestion_at > NOW() - INTERVAL '24 hours') as ingested_24h,
  (SELECT COUNT(*) FROM reviews WHERE created_at > NOW() - INTERVAL '24 hours') as new_reviews_24h,
  (SELECT COUNT(*) FROM draft_replies WHERE status = 'pending_approval') as pending_approvals,
  (SELECT COUNT(*) FROM email_logs WHERE created_at > NOW() - INTERVAL '24 hours' AND status = 'delivered') as emails_delivered_24h,
  (SELECT COUNT(*) FROM email_logs WHERE created_at > NOW() - INTERVAL '24 hours' AND status IN ('bounced','failed')) as emails_failed_24h,
  (SELECT COUNT(*) FROM job_logs WHERE created_at > NOW() - INTERVAL '24 hours' AND status = 'failed') as job_failures_24h;

-- View: Per-Restaurant Status
CREATE OR REPLACE VIEW v_restaurant_status AS
SELECT 
  r.id,
  r.name,
  r.status,
  r.last_ingestion_at,
  r.last_ingestion_error,
  (SELECT COUNT(*) FROM reviews rev WHERE rev.restaurant_id = r.id AND rev.created_at > NOW() - INTERVAL '7 days') as reviews_this_week,
  (SELECT COUNT(*) FROM draft_replies dr WHERE dr.restaurant_id = r.id AND dr.status = 'pending_approval') as pending_drafts,
  (SELECT MAX(scheduled_for) FROM newsletters nl WHERE nl.restaurant_id = r.id) as next_newsletter,
  (SELECT COUNT(*) FROM email_logs el WHERE el.restaurant_id = r.id AND el.created_at > NOW() - INTERVAL '7 days' AND el.status IN ('bounced','failed')) as email_errors_7d
FROM restaurants r
WHERE r.status = 'active'
ORDER BY r.name;

-- View: Email Delivery Health
CREATE OR REPLACE VIEW v_email_health AS
SELECT 
  r.name as restaurant,
  ec.sender_name,
  ec.reply_to_email,
  COUNT(*) as total_sent,
  COUNT(CASE WHEN el.status = 'delivered' THEN 1 END) as delivered,
  COUNT(CASE WHEN el.status = 'bounced' THEN 1 END) as bounced,
  COUNT(CASE WHEN el.status = 'failed' THEN 1 END) as failed,
  ROUND(100.0 * COUNT(CASE WHEN el.status = 'delivered' THEN 1 END) / NULLIF(COUNT(*), 0), 2) as delivery_rate
FROM email_logs el
JOIN restaurants r ON r.id = el.restaurant_id
JOIN email_config ec ON ec.restaurant_id = r.id
WHERE el.created_at > NOW() - INTERVAL '7 days'
GROUP BY r.name, ec.sender_name, ec.reply_to_email
HAVING COUNT(*) > 0
ORDER BY delivery_rate ASC;

-- View: Newsletter Schedule
CREATE OR REPLACE VIEW v_newsletter_schedule AS
SELECT 
  r.name,
  ec.newsletter_day,
  ec.newsletter_time,
  (SELECT MAX(sent_at) FROM newsletters nl WHERE nl.restaurant_id = r.id AND nl.status = 'sent') as last_sent,
  (SELECT MIN(scheduled_for) FROM newsletters nl WHERE nl.restaurant_id = r.id AND nl.status = 'pending') as next_scheduled,
  CASE 
    WHEN EXISTS (SELECT 1 FROM newsletters nl WHERE nl.restaurant_id = r.id AND nl.status = 'failed' AND nl.scheduled_for > NOW() - INTERVAL '7 days') 
    THEN 'FAILED' 
    ELSE 'OK' 
  END as status
FROM restaurants r
JOIN email_config ec ON ec.restaurant_id = r.id
WHERE r.status = 'active'
ORDER BY ec.newsletter_day, ec.newsletter_time;
```

### 3.2 Simple Admin Dashboard (HTML)

Create `~/restaurant-saas/dashboard.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Restaurant SaaS - Admin Dashboard</title>
  <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
  <style>
    body { font-family: system-ui; max-width: 1400px; margin: 20px auto; padding: 0 20px; }
    h1 { border-bottom: 3px solid #333; padding-bottom: 10px; }
    .status-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin: 20px 0; }
    .stat-card { background: #f5f5f5; padding: 20px; border-radius: 8px; border-left: 4px solid #4CAF50; }
    .stat-card.warning { border-left-color: #FF9800; }
    .stat-card.error { border-left-color: #F44336; }
    .stat-value { font-size: 32px; font-weight: bold; }
    .stat-label { font-size: 14px; color: #666; text-transform: uppercase; }
    table { width: 100%; border-collapse: collapse; margin: 20px 0; }
    th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
    th { background: #333; color: white; }
    .status-ok { color: #4CAF50; font-weight: bold; }
    .status-error { color: #F44336; font-weight: bold; }
    .status-warning { color: #FF9800; font-weight: bold; }
    button { background: #333; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 4px; }
    button:hover { background: #555; }
  </style>
</head>
<body>
  <h1>🍽️ Restaurant SaaS - Operations Dashboard</h1>
  <p>Last updated: <span id="last-updated"></span> | <button onclick="loadDashboard()">Refresh</button></p>

  <h2>System Health</h2>
  <div class="status-grid" id="health-stats"></div>

  <h2>Restaurant Status</h2>
  <table id="restaurant-table">
    <thead>
      <tr>
        <th>Restaurant</th>
        <th>Last Ingestion</th>
        <th>Reviews (7d)</th>
        <th>Pending Drafts</th>
        <th>Next Newsletter</th>
        <th>Email Errors</th>
      </tr>
    </thead>
    <tbody id="restaurant-tbody"></tbody>
  </table>

  <h2>Email Delivery (7 days)</h2>
  <table id="email-table">
    <thead>
      <tr>
        <th>Restaurant</th>
        <th>Sender</th>
        <th>Total Sent</th>
        <th>Delivered</th>
        <th>Bounced</th>
        <th>Failed</th>
        <th>Delivery %</th>
      </tr>
    </thead>
    <tbody id="email-tbody"></tbody>
  </table>

  <script>
    const SUPABASE_URL = 'YOUR_SUPABASE_URL';
    const SUPABASE_KEY = 'YOUR_SUPABASE_ANON_KEY';
    const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

    async function loadDashboard() {
      document.getElementById('last-updated').textContent = new Date().toLocaleString();

      // Health stats
      const { data: health } = await supabase.from('v_daily_health').select('*').single();
      if (health) {
        const statsHtml = `
          <div class="stat-card">
            <div class="stat-value">${health.active_restaurants}</div>
            <div class="stat-label">Active Restaurants</div>
          </div>
          <div class="stat-card ${health.ingested_24h < health.active_restaurants ? 'warning' : ''}">
            <div class="stat-value">${health.ingested_24h}/${health.active_restaurants}</div>
            <div class="stat-label">Ingested (24h)</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">${health.new_reviews_24h}</div>
            <div class="stat-label">New Reviews (24h)</div>
          </div>
          <div class="stat-card ${health.job_failures_24h > 0 ? 'error' : ''}">
            <div class="stat-value">${health.job_failures_24h}</div>
            <div class="stat-label">Job Failures (24h)</div>
          </div>
        `;
        document.getElementById('health-stats').innerHTML = statsHtml;
      }

      // Restaurant status
      const { data: restaurants } = await supabase.from('v_restaurant_status').select('*');
      if (restaurants) {
        const rows = restaurants.map(r => {
          const lastIngestion = r.last_ingestion_at 
            ? new Date(r.last_ingestion_at).toLocaleString() 
            : '<span class="status-error">Never</span>';
          const nextNewsletter = r.next_newsletter 
            ? new Date(r.next_newsletter).toLocaleDateString() 
            : 'Not scheduled';
          const emailStatus = r.email_errors_7d > 0 
            ? `<span class="status-error">${r.email_errors_7d} errors</span>` 
            : '<span class="status-ok">OK</span>';
          
          return `
            <tr>
              <td>${r.name}</td>
              <td>${lastIngestion}</td>
              <td>${r.reviews_this_week}</td>
              <td>${r.pending_drafts}</td>
              <td>${nextNewsletter}</td>
              <td>${emailStatus}</td>
            </tr>
          `;
        }).join('');
        document.getElementById('restaurant-tbody').innerHTML = rows;
      }

      // Email health
      const { data: emails } = await supabase.from('v_email_health').select('*');
      if (emails) {
        const rows = emails.map(e => {
          const deliveryClass = e.delivery_rate < 90 ? 'status-error' : (e.delivery_rate < 95 ? 'status-warning' : 'status-ok');
          return `
            <tr>
              <td>${e.restaurant}</td>
              <td>${e.sender_name}</td>
              <td>${e.total_sent}</td>
              <td>${e.delivered}</td>
              <td>${e.bounced}</td>
              <td>${e.failed}</td>
              <td class="${deliveryClass}">${e.delivery_rate}%</td>
            </tr>
          `;
        }).join('');
        document.getElementById('email-tbody').innerHTML = rows;
      }
    }

    // Load on page load
    loadDashboard();
    // Auto-refresh every 5 minutes
    setInterval(loadDashboard, 300000);
  </script>
</body>
</html>
```

**Setup:**
1. Replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY`
2. Host on Vercel/Netlify or serve locally
3. Bookmark for daily checks

### 3.3 Quick CLI Monitoring

Create `~/restaurant-saas/scripts/check-health.sh`:

```bash
#!/bin/bash
# Quick health check from terminal

echo "=== RESTAURANT SAAS HEALTH CHECK ==="
echo "Time: $(date)"
echo ""

# Load database URL
source ~/.openclaw/workspace/.env 2>/dev/null || source ~/restaurant-saas/.env

# Daily health
echo "📊 DAILY OVERVIEW"
psql $DATABASE_URL -c "SELECT * FROM v_daily_health;" -x

echo ""
echo "🏪 RESTAURANT STATUS"
psql $DATABASE_URL -c "
  SELECT name, 
         CASE 
           WHEN last_ingestion_at > NOW() - INTERVAL '24 hours' THEN '✅ Recent'
           WHEN last_ingestion_at > NOW() - INTERVAL '48 hours' THEN '⚠️  1d ago'
           ELSE '❌ Stale'
         END as ingestion,
         pending_drafts,
         email_errors_7d
  FROM v_restaurant_status
  ORDER BY last_ingestion_at ASC NULLS FIRST;
"

echo ""
echo "📧 EMAIL HEALTH"
psql $DATABASE_URL -c "
  SELECT restaurant, delivery_rate,
         CASE 
           WHEN delivery_rate >= 95 THEN '✅'
           WHEN delivery_rate >= 90 THEN '⚠️'
           ELSE '❌'
         END as status
  FROM v_email_health
  ORDER BY delivery_rate ASC;
"

echo ""
echo "🔴 RECENT ERRORS"
psql $DATABASE_URL -c "
  SELECT created_at::timestamp(0), job_type, restaurant_id, error_type 
  FROM job_logs 
  WHERE status = 'failed' AND created_at > NOW() - INTERVAL '24 hours'
  ORDER BY created_at DESC 
  LIMIT 10;
"
```

Make executable:
```bash
chmod +x ~/restaurant-saas/scripts/check-health.sh
```

Run daily:
```bash
./scripts/check-health.sh
```

---

## 4. QUALITY ASSURANCE

### 4.1 Reply Generation Test Plan

**Test Matrix:**

| Test Case | Review Rating | Review Text | Expected Behavior |
|-----------|---------------|-------------|-------------------|
| TC-001 | 5 stars | "Amazing food!" | Grateful, enthusiastic, invites return |
| TC-002 | 1 star | "Worst service ever" | Apologetic, empathetic, offers resolution |
| TC-003 | 3 stars | "Food good but slow" | Balanced, acknowledges both, commits to improvement |
| TC-004 | 5 stars | "Best pasta in town! Maria was so sweet!" | Mentions Maria by name, thanks for specific compliment |
| TC-005 | 2 stars | "Hair in my food" | Sincere apology, takes responsibility, offers refund/makeup visit |
| TC-006 | 4 stars | Generic positive | Personalized despite generic review, not template-y |
| TC-007 | 1 star | Angry/profanity | Stays professional, de-escalates, offers offline resolution |
| TC-008 | 5 stars | Very long (500+ words) | Acknowledges main points, doesn't repeat everything |

**Automated Test Script:**

Create `~/restaurant-saas/tests/reply-quality.test.ts`:

```typescript
import { generateReply } from '../src/services/reply-generator';

const testCases = [
  {
    id: 'TC-001',
    rating: 5,
    text: 'Amazing food!',
    reviewer: 'John D.',
    assertions: {
      includesName: true,
      tone: 'grateful',
      length: [30, 150],
      avoidPhrases: ['Thank you for your feedback', 'We appreciate'],
    }
  },
  {
    id: 'TC-002',
    rating: 1,
    text: 'Worst service ever',
    reviewer: 'Jane S.',
    assertions: {
      includesName: true,
      tone: 'apologetic',
      containsKeywords: ['sorry', 'apologize', 'disappointed'],
      offersResolution: true,
    }
  },
  // ... more test cases
];

async function runTests() {
  console.log('Running reply quality tests...\n');
  
  for (const tc of testCases) {
    const reply = await generateReply({
      reviewText: tc.text,
      rating: tc.rating,
      reviewerName: tc.reviewer,
      restaurantId: 'test-restaurant',
    });

    console.log(`${tc.id}: ${tc.text.substring(0, 50)}...`);
    console.log(`Generated: ${reply.substring(0, 100)}...\n`);

    // Assertions
    if (tc.assertions.includesName && !reply.includes(tc.reviewer)) {
      console.error(`❌ Missing reviewer name`);
    }
    
    if (tc.assertions.length) {
      const wordCount = reply.split(' ').length;
      if (wordCount < tc.assertions.length[0] || wordCount > tc.assertions.length[1]) {
        console.error(`❌ Length ${wordCount} outside range ${tc.assertions.length}`);
      }
    }

    // Add more assertions...
  }
}

runTests();
```

Run monthly:
```bash
npm run test:reply-quality
```

### 4.2 Newsletter Content Validation

**Pre-Send Checklist:**

Before any newsletter goes out, verify:

- [ ] **Data Accuracy**
  - Review count matches database query
  - Average rating calculated correctly
  - Sentiment breakdown adds up to 100%
  - No duplicate reviews shown

- [ ] **Competitor Insights**
  - Competitor names spelled correctly
  - Star ratings are current (fetched recently)
  - Comparison data is relevant (same category)
  - No missing or "undefined" data

- [ ] **Formatting**
  - All images load (test in Gmail, Outlook, Apple Mail)
  - Links work and go to correct destinations
  - No broken HTML tags
  - Charts render correctly
  - Mobile responsive (test on phone)

- [ ] **Content Quality**
  - Tone matches restaurant brand
  - Grammar/spelling correct (run through Grammarly)
  - Call-to-action is clear
  - Unsubscribe link works

**Automated Validation Script:**

```typescript
// ~/restaurant-saas/tests/newsletter-validator.ts

async function validateNewsletter(newsletterId: string) {
  const newsletter = await db.newsletters.findById(newsletterId);
  const errors = [];

  // Check review count
  const actualReviewCount = await db.reviews.count({
    restaurantId: newsletter.restaurantId,
    createdAt: { gte: newsletter.startDate, lte: newsletter.endDate }
  });
  
  if (newsletter.content.reviewCount !== actualReviewCount) {
    errors.push(`Review count mismatch: ${newsletter.content.reviewCount} vs ${actualReviewCount}`);
  }

  // Check for broken links
  const links = newsletter.html.match(/href="([^"]+)"/g) || [];
  for (const link of links) {
    const url = link.match(/href="([^"]+)"/)[1];
    if (!url.startsWith('http')) {
      errors.push(`Invalid link: ${url}`);
    }
  }

  // Check for undefined/null in content
  if (newsletter.html.includes('undefined') || newsletter.html.includes('null')) {
    errors.push('Content contains undefined or null values');
  }

  // Check competitor data
  for (const comp of newsletter.content.competitors) {
    if (!comp.name || !comp.rating) {
      errors.push(`Incomplete competitor data: ${JSON.stringify(comp)}`);
    }
  }

  return errors;
}
```

### 4.3 Email Deliverability Testing

**Setup Email Testing:**

Use [Mail-Tester.com](https://www.mail-tester.com/) for deliverability scoring.

```bash
# Send test email to mail-tester
npm run email:test -- --to=test-xyz@mail-tester.com --type=newsletter

# Wait 30 seconds, then check score at mail-tester.com
```

**Target Scores:**
- **10/10:** Perfect, go live
- **8-9/10:** Good, minor tweaks recommended
- **6-7/10:** Fix issues before sending to customers
- **<6/10:** Do not send, serious problems

**Common Issues:**

| Issue | Solution |
|-------|----------|
| Low sender reputation | Warm up domain with small batches first |
| Missing DKIM/SPF | Configure in Resend settings |
| Spammy words ("Free!", "Click now!") | Rewrite content |
| High image-to-text ratio | Add more text, reduce images |
| Broken links | Fix URLs |
| No unsubscribe link | Add unsubscribe footer |

**Inbox Placement Test:**

Create test accounts on:
- Gmail (personal, not workspace)
- Outlook/Hotmail
- Yahoo Mail
- Apple iCloud Mail

Send newsletter to all, check:
- [ ] Lands in inbox (not spam/promotions)
- [ ] Images load
- [ ] Links work
- [ ] Unsubscribe works

### 4.4 Edge Case Handling

**Edge Case Test Suite:**

```bash
# No reviews this week
npm run newsletter:generate -- --restaurant-id=<id> --mock-no-reviews

# All 5-star reviews
npm run newsletter:generate -- --restaurant-id=<id> --mock-all-5star

# All 1-star reviews  
npm run newsletter:generate -- --restaurant-id=<id> --mock-all-1star

# Competitor has no data
npm run newsletter:generate -- --restaurant-id=<id> --mock-competitor-missing

# Special characters in review
npm run replies:generate -- --review-text="Great food! 🍕❤️ Can't wait to come back!"

# Very long review (1000+ words)
npm run replies:generate -- --review-text="$(cat long-review.txt)"

# Empty review (just star rating)
npm run replies:generate -- --review-text="" --rating=5
```

**Expected Behaviors:**

| Edge Case | Expected Behavior |
|-----------|-------------------|
| No reviews this week | Newsletter still sent with message: "No new reviews this week! Focus on delivering great experiences." + competitor insights |
| All 5-star | Celebratory tone: "What an amazing week! 100% five-star reviews!" |
| All 1-star | Supportive tone: "Tough week. Let's review what happened and create an action plan." |
| Competitor missing | Gracefully omit that competitor, show others, or show "Data unavailable" |
| Special chars/emoji | Properly encoded in email, no broken characters |
| Long review | Summarized to 100-150 words in reply |
| Empty review | Generic but warm reply: "Thank you for the rating! We hope to see you again soon." |

---

## 5. PILOT SUCCESS METRICS

### 5.1 Technical Metrics (SLAs)

**Uptime & Reliability:**

| Metric | Target | Measurement | Red Flag |
|--------|--------|-------------|----------|
| System Uptime | 99.5% | `uptime` command, logs | <99% |
| Review Ingestion Success Rate | 98% | Successful jobs / Total jobs | <95% |
| Email Delivery Rate | 97% | Delivered / Sent | <95% |
| API Response Time (p95) | <3s | Application logs | >5s |
| Database Query Time (p95) | <500ms | Slow query log | >1s |

**Monitoring Query:**

```sql
-- Weekly technical health report
SELECT 
  DATE_TRUNC('week', created_at) as week,
  job_type,
  COUNT(*) as total_jobs,
  COUNT(CASE WHEN status = 'success' THEN 1 END) as successful,
  COUNT(CASE WHEN status = 'failed' THEN 1 END) as failed,
  ROUND(100.0 * COUNT(CASE WHEN status = 'success' THEN 1 END) / COUNT(*), 2) as success_rate
FROM job_logs
WHERE created_at > NOW() - INTERVAL '4 weeks'
GROUP BY DATE_TRUNC('week', created_at), job_type
ORDER BY week DESC, job_type;
```

**Response Time:**

Track average time from review posted → draft reply generated:

```sql
SELECT 
  AVG(EXTRACT(EPOCH FROM (dr.created_at - r.review_date))) / 3600 as avg_hours
FROM draft_replies dr
JOIN reviews r ON r.id = dr.review_id
WHERE dr.created_at > NOW() - INTERVAL '7 days';
```

Target: <2 hours

### 5.2 Customer Satisfaction Metrics

**Approval Rate:**

What % of draft replies are approved vs edited vs rejected?

```sql
SELECT 
  r.name,
  COUNT(*) as total_drafts,
  COUNT(CASE WHEN dr.status = 'approved' AND dr.edited = false THEN 1 END) as approved_as_is,
  COUNT(CASE WHEN dr.status = 'approved' AND dr.edited = true THEN 1 END) as approved_with_edits,
  COUNT(CASE WHEN dr.status = 'rejected' THEN 1 END) as rejected,
  ROUND(100.0 * COUNT(CASE WHEN dr.status = 'approved' AND dr.edited = false THEN 1 END) / NULLIF(COUNT(*), 0), 2) as approval_rate
FROM draft_replies dr
JOIN restaurants r ON r.id = dr.restaurant_id
WHERE dr.created_at > NOW() - INTERVAL '30 days'
GROUP BY r.name
ORDER BY approval_rate DESC;
```

**Target:** >80% approved as-is

**Feedback Score:**

After each newsletter, include a 1-click satisfaction survey:

```
How helpful was this week's newsletter?
[⭐ Not helpful] [⭐⭐ Somewhat] [⭐⭐⭐ Helpful] [⭐⭐⭐⭐ Very helpful] [⭐⭐⭐⭐⭐ Excellent]
```

Track in database:

```sql
CREATE TABLE newsletter_feedback (
  id SERIAL PRIMARY KEY,
  newsletter_id INT REFERENCES newsletters(id),
  restaurant_id INT REFERENCES restaurants(id),
  rating INT CHECK (rating >= 1 AND rating <= 5),
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Target:** Average rating >4.0

**Net Promoter Score (NPS):**

Monthly survey:

"How likely are you to recommend [SaaS Name] to another restaurant owner?"
[0-10 scale]

- **Promoters (9-10):** Loyal, will refer
- **Passives (7-8):** Satisfied but unenthusiastic
- **Detractors (0-6):** Unhappy, might churn

**NPS = % Promoters - % Detractors**

**Target:** NPS >50 (world-class is 70+)

### 5.3 Business Metrics

**Retention:**

Are pilots still active after 30/60/90 days?

```sql
SELECT 
  CASE 
    WHEN NOW() - created_at < INTERVAL '30 days' THEN '<30 days'
    WHEN NOW() - created_at < INTERVAL '60 days' THEN '30-60 days'
    WHEN NOW() - created_at < INTERVAL '90 days' THEN '60-90 days'
    ELSE '>90 days'
  END as cohort,
  COUNT(*) as total,
  COUNT(CASE WHEN status = 'active' THEN 1 END) as still_active,
  ROUND(100.0 * COUNT(CASE WHEN status = 'active' THEN 1 END) / COUNT(*), 2) as retention_rate
FROM restaurants
GROUP BY cohort
ORDER BY cohort;
```

**Target:** >90% retention at 30 days, >70% at 90 days

**Willingness to Pay:**

During 30-day check-in, ask:

"When the pilot ends, what monthly price would feel fair for this service?"
- [ ] $0 (wouldn't pay)
- [ ] $49/mo
- [ ] $99/mo
- [ ] $149/mo
- [ ] $199/mo
- [ ] $249+/mo

Track responses:

```sql
CREATE TABLE pricing_feedback (
  id SERIAL PRIMARY KEY,
  restaurant_id INT REFERENCES restaurants(id),
  willing_to_pay_cents INT,
  feedback_text TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Target:** >80% willing to pay ≥$99/mo

**Referrals:**

Ask during check-ins: "Do you know any other restaurant owners who'd benefit?"

Track referrals:

```sql
CREATE TABLE referrals (
  id SERIAL PRIMARY KEY,
  referring_restaurant_id INT REFERENCES restaurants(id),
  referred_restaurant_name TEXT,
  referred_contact_email TEXT,
  status TEXT, -- 'pending', 'contacted', 'signed_up', 'declined'
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Target:** ≥1 referral per 3 pilots (33% referral rate)

### 5.4 Weekly Pilot Report

Create automated weekly report:

```bash
# ~/restaurant-saas/scripts/pilot-report.sh

#!/bin/bash
echo "=== WEEKLY PILOT SUCCESS REPORT ==="
echo "Week of: $(date -v-7d '+%Y-%m-%d') to $(date '+%Y-%m-%d')"
echo ""

psql $DATABASE_URL -c "
  -- Technical health
  SELECT 'TECHNICAL METRICS' as section, NULL as metric, NULL as value
  UNION ALL
  SELECT '', 'Uptime', (SELECT ROUND(100.0 * COUNT(CASE WHEN status = 'success' THEN 1 END) / COUNT(*), 2)::TEXT || '%' FROM job_logs WHERE created_at > NOW() - INTERVAL '7 days')
  UNION ALL
  SELECT '', 'Avg Response Time', (SELECT ROUND(AVG(EXTRACT(EPOCH FROM (dr.created_at - r.review_date))) / 3600, 1)::TEXT || ' hours' FROM draft_replies dr JOIN reviews r ON r.id = dr.review_id WHERE dr.created_at > NOW() - INTERVAL '7 days')
  UNION ALL
  SELECT '', 'Email Delivery Rate', (SELECT ROUND(100.0 * COUNT(CASE WHEN status = 'delivered' THEN 1 END) / COUNT(*), 2)::TEXT || '%' FROM email_logs WHERE created_at > NOW() - INTERVAL '7 days')
  
  UNION ALL SELECT '', '', ''
  
  -- Customer satisfaction
  UNION ALL SELECT 'CUSTOMER SATISFACTION' as section, NULL, NULL
  UNION ALL SELECT '', 'Draft Approval Rate', (SELECT ROUND(100.0 * COUNT(CASE WHEN status = 'approved' AND edited = false THEN 1 END) / COUNT(*), 2)::TEXT || '%' FROM draft_replies WHERE created_at > NOW() - INTERVAL '7 days')
  UNION ALL SELECT '', 'Avg Newsletter Rating', (SELECT ROUND(AVG(rating), 2)::TEXT || '/5' FROM newsletter_feedback WHERE created_at > NOW() - INTERVAL '7 days')
  
  UNION ALL SELECT '', '', ''
  
  -- Business metrics
  UNION ALL SELECT 'BUSINESS METRICS' as section, NULL, NULL
  UNION ALL SELECT '', 'Active Pilots', (SELECT COUNT(*)::TEXT FROM restaurants WHERE status = 'active')
  UNION ALL SELECT '', 'Retention (30d)', (SELECT ROUND(100.0 * COUNT(CASE WHEN status = 'active' THEN 1 END) / COUNT(*), 2)::TEXT || '%' FROM restaurants WHERE created_at < NOW() - INTERVAL '30 days')
  UNION ALL SELECT '', 'New Referrals', (SELECT COUNT(*)::TEXT FROM referrals WHERE created_at > NOW() - INTERVAL '7 days');
" -x

# Email to team
echo "Emailing report..."
# (Use your preferred email method)
```

Run every Monday at 9am:
```bash
crontab -e
0 9 * * 1 ~/restaurant-saas/scripts/pilot-report.sh | mail -s "Weekly Pilot Report" team@yourstartup.com
```

---

## 6. EMERGENCY CONTACTS & ESCALATION

### 6.1 On-Call Rotation

**Primary On-Call:** [Your Name] - [Phone] - [Email]  
**Backup:** [Backup Name] - [Phone] - [Email]  
**Engineering Escalation:** [Dev Name] - [Phone]

### 6.2 Escalation Matrix

| Severity | Response Time | Who to Contact | Examples |
|----------|---------------|----------------|----------|
| **P0 - Critical** | <15 min | Primary on-call + backup | Complete system down, data loss, security breach |
| **P1 - High** | <1 hour | Primary on-call | Multiple restaurants failing, email delivery broken |
| **P2 - Medium** | <4 hours | Primary on-call (during business hours) | Single restaurant issue, delayed newsletter |
| **P3 - Low** | <24 hours | Handle during next business day | Feature request, minor bug, cosmetic issue |

### 6.3 Incident Response Runbook

**If system is completely down:**

1. **Assess** (2 min):
   - Check server status: `ssh server` + `systemctl status app`
   - Check database: `psql $DATABASE_URL -c "SELECT 1;"`
   - Check logs: `tail -100 /var/log/app.log`

2. **Communicate** (5 min):
   - Post in Slack: "🚨 System down, investigating"
   - Email all active pilots: "We're experiencing technical issues. Estimated restore time: [X]"

3. **Fix** (varies):
   - Restart services: `systemctl restart app`
   - Check env vars: `cat .env` (are keys valid?)
   - Rollback deployment if recent: `git checkout <previous-commit>; npm run deploy`

4. **Verify** (5 min):
   - Test ingestion: `npm run ingestion -- --restaurant-id=1 --dry-run`
   - Test email: `npm run email:test`
   - Check dashboard: All green?

5. **Post-Mortem** (within 24h):
   - Document what happened, why, how we fixed it
   - What to prevent next time?
   - Share with team + customers (transparency builds trust)

### 6.4 Vendor Support Contacts

| Service | Support | SLA | Escalation |
|---------|---------|-----|------------|
| **Supabase** | support@supabase.com | 24h response | Status: https://status.supabase.com |
| **Resend** | support@resend.com | 12h response | Status: https://resend.com/status |
| **OpenAI** | help.openai.com | 24h response | Status: https://status.openai.com |
| **Google Maps API** | Google Cloud Console | Community forum | Status: https://status.cloud.google.com |

---

## APPENDIX: Quick Reference Commands

```bash
# Health check
./scripts/check-health.sh

# Manual ingestion (single restaurant)
npm run ingestion -- --restaurant-id=<id> --force

# Regenerate newsletter
npm run newsletter:generate -- --restaurant-id=<id> --force

# Resend email
npm run email:retry -- --email-log-id=<id>

# Test reply generation
npm run test:reply -- --review-id=<id>

# Export restaurant data (GDPR)
npm run export:restaurant-data -- --restaurant-id=<id>

# Database backup
pg_dump $DATABASE_URL > backup-$(date +%Y%m%d).sql

# View live logs
tail -f /var/log/app.log | grep ERROR

# Check cron jobs
crontab -l

# Restart all services
systemctl restart app nginx postgres
```

---

## CHANGELOG

| Date | Change | Author |
|------|--------|--------|
| 2026-02-10 | Initial creation | QA/Ops Agent |

---

**END OF OPERATIONS MANUAL**

*This is a living document. Update as you learn. Every incident is a lesson. Every customer complaint is a feature request.*

**Remember:** The goal isn't zero failures—it's fast recovery and continuous improvement. 🚀
