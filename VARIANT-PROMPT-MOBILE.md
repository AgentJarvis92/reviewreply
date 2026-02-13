# Variant.com Mobile Landing Page - Maitreo

**CRITICAL:** This is a MOBILE-ONLY design. Design for 375px width (iPhone). Every element must look perfect on a phone screen. Do not design for desktop. Think mobile app landing page, not desktop website.

---

## VISUAL IDENTITY

**Minimal luxury. Clean. Precise. Mobile-native.**

### Color Palette
- **Background:** `#FFFFFF` (white sections), `#F4F5F7` (gray sections), `#1F2A34` (dark sections)
- **Text:** `#111111` (primary), `#6B6B6B` (muted)
- **Accent:** `#2B3A44` (buttons, links)
- **Hover:** `#1E2A33`
- **Dividers:** `#E6E8EB`
- **SMS bubbles:** `#4A6274` (user replies)
- **Alert borders:** `#C9A84C` (amber, negative), `#C45C5C` (red, urgent)

### Typography
- **Headlines:** Playfair Display (serif)
- **Body:** Inter (sans-serif)
- **Rule:** Serif for presence, sans-serif for function

### Mobile Design Rules
- **Max content width: 375px** - design everything for this width
- **Horizontal padding: 16px (1rem) on each side** - content area is ~343px
- **Font sizes:** Headlines max 28px. Body 14-16px. Small text 12px. Nothing bigger.
- **Generous vertical spacing** between sections (48-64px padding top/bottom)
- **Single column everything** - no side-by-side layouts
- **Tap targets: minimum 44px height** for all buttons and interactive elements
- **No tiny text** - smallest text is 12px
- **Icons: 24px, single solid color, thin-line style**
- **No gradients, no shadows on buttons, no glow effects**
- **Sharp corners on buttons (4-6px radius max)**

---

## PAGE STRUCTURE

### 0. TOP NAV (not sticky, scrolls away)
- **Background:** `#F4F5F7`
- **Left:** Small "M" circle (24px, `#2B3A44`) + "Maitreo" in serif, ~18px
- **Right:** "Start Free Trial" button, small (`#2B3A44` bg, white text, 12px font)
- **Height:** ~56px total
- **Padding:** 16px horizontal, 12px vertical

---

### 1. HERO (Dark background `#1F2A34`)

**Keep this tight on mobile. Show the product fast.**

**Headline (serif, white, 24-28px max):**
```
Your Reputation
Has a Maître d' Now.
```
"Has a Maître d' Now." in italic, slightly lighter gray (#D1D5DB)

**Subtitle (sans-serif, 14-15px, gray `#9CA3AF`, 2-3 lines max):**
```
Maitreo monitors every review, responds in your voice, and alerts you instantly when something needs attention. All by SMS.
```

**CTA Button (full width, `#FFFFFF` bg, `#1F2A34` text, 48px height, bold, 14px):**
```
Start Free Trial
```

**Small text below button (12px, gray `#6B6B6B`):**
```
7 days free. Works with Google, Yelp & TripAdvisor.
```

**Then immediately: the SMS conversation.** This is the hero visual. It should take up most of the hero on mobile.

**SMS Conversation (animated, sequential fade-in):**

Centered "M" circle (32px, `#4A6274`) + "Maitreo" label above bubbles.

**Bubble 1 (white bg, dark text, full width minus 16px padding):**
```
✓ Auto-posted reply to Maria L.'s 4.5★ Google review.
"Thank you, Maria! Evenings like yours are exactly why we do what we do here at The Pepper Room."
```

**Bubble 2 (white bg, amber left border `#C9A84C`):**
```
⚠ New 2★ Yelp review from James R.
Mentions long wait for entrées.

Draft reply: "James, we appreciate the feedback. A 40-minute wait is not the standard we hold ourselves to at The Pepper Room. We're addressing this with our kitchen team directly."

Reply YES to post, or send your own.
```

**Bubble 3 (right-aligned, `#4A6274` bg, white text, compact):**
```
YES
```

**Bubble 4 (white bg, compact):**
```
✓ Posted.
```

**Bubble 5 (white bg, red left border `#C45C5C`):**
```
⚠ URGENT: 2 negative reviews in 6 hours.
Both mention slow service.
• Check kitchen timing and staffing
• Consider pulling a manager to expo
• Monitor next 2 hours for additional signals
```

**Below SMS bubbles:**
Small green dot + "Monitoring Google..." cycling text (12px, green `#22C55E`, monospace)

**Below that, small muted checkmarks (12px, `#9CA3AF`):**
```
✔ Monitors every 15 minutes
✔ Auto-responds to positive reviews
✔ Instant alerts for negative reviews
```

---

### 2. "WHAT A MAÎTRE D' DOES" (White bg)

**Headline (serif, centered, 20-22px, `#111111`):**
```
A Great Maître d' Watches Everything. So Does Maitreo.
```

**Subtitle (14px, centered, `#6B6B6B`):**
```
Maitreo brings front-of-house awareness to your online reputation.
```

**3 stacked cards (not side by side), each card:**
- Centered icon (24px, navy `#2B3A44`)
- Title (serif, 16-18px, bold)
- Description (14px, `#6B6B6B`)
- Spacing: 32px between cards

Card 1: 👁 Eye icon → "Watches the room" → "monitors reviews everywhere"
Card 2: ✋ Hand icon → "Steps in when needed" → "alerts you instantly"
Card 3: 📋 Clipboard icon → "Maintains standards" → "detects patterns over time"

---

### 3. CRISIS MODE (Dark bg `#1F2A34`)

**Headline (serif, white, 20-22px):**
```
When Something Goes Wrong, You'll Know Immediately.
```

**Timeline (vertical, left-aligned, thin line connecting dots):**
```
6:12 PM — 2★ review mentions cold food
7:03 PM — 1★ review mentions slow service
7:04 PM — Maitreo alerts you: Possible operational issue detected.
```

**Supporting text (14px, gray):**
```
Before ratings drop. Before word spreads. Before bookings fall.
```

---

### 4. THREE PILLARS (Gray bg `#F4F5F7`)

**Headline (serif, centered, 20-22px):**
```
Three Pillars of Reputation Oversight
```

**3 stacked cards (white bg, full width, subtle border `#E6E8EB`, 16px padding):**

**Card 1 - Continuous Awareness**
- Radar icon (24px, navy)
- Bullet list (14px): Monitors every platform, Pattern detection, Staff mentions, Photo tracking
- Badge: "Checked every 15 minutes, 24/7"
- Micro example: "3 reviews mentioned 'slow service' this week"

**Card 2 - Intelligent Response**
- Message icon (24px, navy)
- Bullet list: Auto replies to positive, Approval for negative, Voice matching, Instant SMS control
- Micro example: "Thank you, Maria! We're so glad you loved..."

**Card 3 - Strategic Intelligence**
- Graph icon (24px, navy)
- Bullet list: Weekly report, Competitor growth tracking, Ranking changes, Trend analysis
- Micro example: "Competitor gained +200% reviews this week"

---

### 5. WEEKLY INTELLIGENCE BRIEFING (Gray bg `#F4F5F7`)

**Headline (serif, centered, 20-22px):**
```
Your Weekly Reputation Intelligence Briefing
```

**Subtitle (14px, centered):**
```
Everything that changed, everything that matters, and everything you should act on. Delivered every Sunday morning.
```

**Digest Panel (white bg, full width, subtle shadow, rounded 8px):**

This is a DESIGNED newsletter preview. Not plain text. Think Morning Brew quality.

**Panel header:** "Maitreo Digest" left, "The Pepper Room" right, thin divider below.

**Block 1 - This Week at a Glance**
Horizontal scrollable row of metric cards:
- 14 new reviews (+40% ↑)
- 4.6 avg rating (↑ from 4.4)
- 18 min response time
- Improving sentiment

**Block 2 - Patterns We Noticed**
Stacked insight cards with navy left border:
- "Slow service" in 3 reviews (up from 1)
- Maria mentioned positively 5 times
- Outdoor seating praised repeatedly

**Block 3 - Competitor Watch**
- Miami Chop House: +12 reviews (growth anomaly tag)
- Harbor Grill: 4.5 → 4.2 (downward trend)

**Block 4 - Recommended Actions**
Checklist style:
- ☐ Investigate Friday dinner service timing
- ☐ Recognize Maria for guest experience
- ☐ Monitor Miami Chop House next 2 weeks

**Closing line (centered, 14px, bold):**
```
Most restaurants react to reviews. Maitreo helps you anticipate trends.
```

---

### 6. COMPETITOR INTELLIGENCE (Gray bg `#F4F5F7`)

**Headline (serif, centered, 20-22px):**
```
Know What's Happening Across the Street
```

**Example card (white bg, border, full width):**
```
Miami Chop House
+12 reviews this week (typical avg: 4)
Growth anomaly detected
```

**Closing (centered, bold, 14px):**
```
Most restaurants only watch themselves. Maitreo watches the market.
```

---

### 7. DASHBOARD VS SMS (Gray bg `#F4F5F7`)

**Headline (serif, centered, 20-22px):**
```
Most Tools Give You Dashboards. Maitreo Sends a Text.
```

**On mobile, show these STACKED, not side by side:**

**First: SMS phone mockup** (the good option first)
- Thin rounded rectangle outline, no device chrome
- Full SMS conversation inside (same as hero but shorter)
- Caption below: "No dashboard. No analysis. Just clarity."

**Then: Dashboard mockup** (the bad option second)
- Monochrome, busy, overwhelming dashboard screenshot
- Grayed out, slightly faded (opacity 60-70%)
- Caption below: "Another dashboard. Another login. Another thing to check."

**No "vs" circle on mobile.**

---

### 8. COMPARISON TABLE (White bg)

**Headline (serif, centered, 20-22px):**
```
How Reputation Is Managed
```

**On mobile, use stacked comparison cards instead of a table:**

**Card format (repeated for each row):**
```
Without Maitreo: Check 3 platforms separately
With Maitreo: All platforms monitored every 15 minutes
```

Use red-ish muted text for "without" and green-ish or navy for "with". Visual contrast matters.

5 comparison pairs:
1. Check 3 platforms separately vs All platforms monitored every 15 min
2. React after damage vs Early warning alerts
3. Guess what's wrong vs Pattern detection
4. No competitor insight vs Market intelligence
5. Time-consuming vs Automatic

---

### 9. PRICING (Gray bg `#F4F5F7`)

**Small label (12px, uppercase, tracking-wide, `#6B6B6B`):**
```
Simple Pricing
```

**Price (serif, large, 36-40px, centered):**
```
$99/month per location
```

**Features (stacked checkmarks, 14px, single column):**
- ✔ All 3 platforms included
- ✔ Unlimited reviews
- ✔ AI-powered replies
- ✔ Weekly competitive intelligence
- ✔ SMS alerts + email digest
- ✔ 7-day free trial
- ✔ Cancel anytime

**CTA Button (full width, `#2B3A44` bg, white text, 48px, bold):**
```
Start Free Trial
```

---

### 9.5. FIRST WEEK EXPERIENCE (White bg)

**Headline (serif, centered, 20-22px):**
```
What Happens After You Start
```

**4 steps, stacked vertically with step numbers:**

Step 1: Enter restaurant name and address
Step 2: Connect review platforms (OAuth links sent to email)
Step 3: Maitreo begins monitoring within 24 hours
Step 4: First alert arrives when something needs attention

Use numbered circles (1-4) in navy with step text beside each.

---

### 10. TESTIMONIALS (Gray bg `#F4F5F7`)

**Headline (serif, centered, 20-22px):**
```
Proof of Impact
```

**3 stacked testimonial cards (white bg, full width, subtle border or left navy border):**

```
"We caught a service issue on a Saturday night before it affected our rating. Fixed it immediately."
— Marco T., The Pepper Room, Miami
```

```
"We didn't realize a new competitor was gaining traction until Maitreo flagged it."
— Sarah K., Harbor Grill, Seattle
```

```
"Response time dropped from hours to minutes. Our rating went from 4.2 to 4.6 in two months."
— David L., Tuscany Kitchen, San Francisco
```

---

### 11. FAQ (White bg)

**Headline (serif, centered, 20-22px):**
```
Common Questions
```

**Accordion-style Q&A, full width:**

Q: Will replies sound robotic?
A: No. We learn your voice during onboarding. Every reply is customized to your brand.

Q: How long does setup take?
A: 2 minutes. Enter your restaurant name and address. We find your listings automatically.

Q: What platforms do you monitor?
A: Google Reviews, Yelp, and TripAdvisor.

Q: Can I cancel anytime?
A: Yes. Reply CANCEL to any Maitreo text, or use the link in your weekly digest. No hoops.

Q: Do you post reviews without my approval?
A: Positive reviews (4-5 stars) auto-post. Negative reviews always require your YES via SMS.

Q: What if I'm closed on Sundays?
A: The digest arrives Sunday 9am, perfect for planning. We can adjust the day if needed.

---

### 12. FINAL CTA (Dark bg `#1F2A34`)

**Headline (serif, white, 22-24px, centered):**
```
Your Maître d' Is Ready for Service.
```

**Subtitle (14px, gray):**
```
Continuous reputation monitoring begins the moment you start.
```

**CTA Button (full width, white bg, dark text, 48px, bold):**
```
Begin Service
```

**Small text (12px, gray):**
```
No dashboard. No setup complexity. Just attentive oversight.
```

---

## FINAL RULES

- **This is MOBILE ONLY (375px).** Do not add desktop breakpoints or responsive layouts.
- **Single column everywhere.** No side-by-side anything.
- **Full-width buttons** on all CTAs (with 16px side padding).
- **48px minimum button height** for all CTAs.
- **No text larger than 28px.**
- **16px horizontal padding on all sections.**
- **Clean section transitions** - alternating white/gray/dark backgrounds for rhythm.
- **All icons: thin-line, single solid color (navy #2B3A44), clearly visible.**
- **No em dashes anywhere.** Use commas, periods, or "—" (regular dash) sparingly.
- Follow copy EXACTLY as written. Do not change wording.
