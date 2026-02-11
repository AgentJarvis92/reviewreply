# ReviewReply Product Updates - 2026-02-11

**Meeting with Kevin: 12:00 PM - 12:22 PM EST**

## Key Decisions

### 1. Pricing Change
**Old:** $49/month per location  
**New:** $99/month per location

**Reasoning:**
- Better margins (96% vs 92%)
- Doesn't feel "cheap" or low-quality
- Still 50-75% cheaper than $200-500 competitors
- More sustainable long-term
- Restaurant owners spend $99 without hesitation

**Action Items:**
- [ ] Update landing page pricing
- [ ] Update Variant prompt (in progress)
- [ ] Create new Stripe $99/month payment link
- [ ] Update all marketing copy

---

### 2. Single Tier Strategy (For Now)
- Launch with one plan: $99/month
- Can add tiers later (Basic/Pro/Business)
- Grandfather existing customers at their original price
- Keeps MVP simple, faster to launch

---

### 3. Advanced Features Added

#### A. Competitor Intelligence (5-Mile Radius)
**What:** Track 10-20 similar restaurants within 5 miles
**How:** AI learns baselines, detects growth anomalies
**Weekly Digest Shows:** Top 3-5 fastest-growing competitors by review volume

**Example:**
> "🔥 Sally's Italian: +12 reviews this week (usual: 4/week = 200% growth)
> Check their Instagram - likely running a campaign"

#### B. Issue Pattern Detection
**What:** Flag if 2+ reviews mention same problem within 7 days
**Alert:** "⚠️ 3 reviews mentioned 'slow service' - check staffing"

#### C. Crisis Mode
**What:** If 2+ negative reviews within 24 hours, send urgent SMS
**Alert:** "🚨 URGENT: 2 negative reviews in 6 hours. Something's wrong tonight."

#### D. Staff Shoutouts
**What:** Track when reviews mention staff by name (positive mentions)
**Weekly Digest:** "👏 Maria mentioned 5x, Carlos mentioned 3x"

#### E. Photo Review Alerts
**What:** Flag reviews with photos (especially 5-star with photos)
**Weekly Digest:** "📸 4 customers posted food photos - repost potential"

#### F. Google Ranking Tracker (Monthly)
**What:** Track Google Maps ranking for key searches
**Monthly Digest:** "'Italian restaurant [city]': #3 (up from #5)"

#### G. Best Review of the Week
**What:** AI picks the most glowing review to highlight
**Weekly Digest:** "🏆 Sarah M. - 'This place is incredible!...'"

---

### 4. Weekly Digest System

**Delivery:** SMS link + Email backup, both Sunday 6pm

**SMS Message:**
```
📊 This week: 12 reviews, Sally's Italian +200%, Maria mentioned 5x. 
Tap for full intel → reviewreply.com/digest/abc123
```

**Email + Web Page Structure:**
1. At a Glance (10 sec) - metrics
2. Alerts (15 sec) - patterns, crisis, photos
3. Wins (20 sec) - staff MVPs, best review
4. Competitor Intel (30 sec) - top movers, insights
5. Your Ranking (10 sec, monthly only)

**Total read time:** 90 seconds (skim) to 3 minutes (deep read)

**Implementation:**
- Web digest page: `/digest/{restaurant_id}/{secure_token}/{week}`
- Mobile-first design
- Magic link (no login required)
- Expires after 30 days

---

### 5. Communication Rules

**SMS = Action Required Only**
- ✅ Negative review alerts (need approval)
- ✅ Crisis mode (urgent)
- ✅ Weekly digest link (Sunday 6pm)
- ❌ Positive reviews (silent/auto)
- ❌ Daily summaries

**Email = Intelligence Reports**
- ✅ Weekly digest (full version)
- ✅ Backup for SMS link
- ❌ Individual review notifications

---

### 6. Database Schema Expansion

**New Tables Needed:**
- `competitors` - tracked restaurants
- `competitor_reviews` - historical data
- `patterns` - recurring issues
- `staff_mentions` - name tracking
- `weekly_digests` - content + delivery tracking

---

## Updated Build Plan

See: `/Users/jarvis/restaurant-saas/BUILD_PLAN.md`

**Current Status:** Foundation complete (Supabase, OpenAI, Google account)
**Next Steps:** 
1. Enable Google Places API
2. Complete Twilio verification
3. Get Yelp Fusion API key
4. Build competitor tracking system
5. Build all 6 advanced features
6. Build weekly digest generator
7. Update landing page to $99
8. Find 3-5 pilot restaurants

**Target Launch:** 2026-02-21 (10 days from start)

---

## Competitive Advantage

**What competitors DON'T have:**
- Competitor growth tracking
- Pattern detection across reviews
- Crisis mode alerts
- Staff performance tracking
- Photo content opportunities
- Ranking insights

**Our edge:** Not just handling reviews, but providing competitive intelligence to help restaurants grow.

**Value prop evolution:**
- Old: "We handle your reviews"
- New: "We handle your reviews + give you competitive intelligence to grow"

This justifies $99 easily and creates a moat.

---

## Cost Analysis

**Per Customer Monthly Costs:**
- Twilio SMS: ~$2 (negative alerts + weekly digest link)
- OpenAI API: ~$1.50 (GPT-4 response generation)
- Review monitoring: ~$0.50 (API calls)
- **Total:** ~$4/month

**Revenue:** $99/month  
**Margin:** 96%  
**Break-even:** 1 customer covers all infrastructure costs

---

**Last Updated:** 2026-02-11 12:22 PM EST
