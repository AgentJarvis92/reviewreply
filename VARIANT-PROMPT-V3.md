# Variant.com Landing Page - Maitreo v3

**CRITICAL INSTRUCTION:** Follow these specifications EXACTLY. Do not deviate from the provided content, structure, visual direction, or copy. This is a FULL responsive landing page (desktop + tablet + mobile). Every section must be present. Do not skip sections. Use the EXACT copy provided. Do not rewrite, rephrase, or abbreviate any text.

---

## PROJECT OVERVIEW

**Product:** Maitreo - AI-powered reputation management for restaurants
**URL:** maitreo.com
**Target Audience:** Medium to high-end restaurant owners (1-5 locations)
**Positioning:** "Your Digital Maître d' for Guest Experience & Reputation"

---

## VISUAL IDENTITY - DARK EDITORIAL LUXURY

### Design Philosophy
**Dark. Editorial. Cinematic. Architectural.**

Think: Aman Resorts website, Bottega Veneta, Aesop, high-end architectural photography books.

The entire page lives on a dark background. Content is revealed through contrast, typography, and photography. This is a luxury hospitality brand, not a SaaS dashboard.

### Color Palette (USE EXACTLY)

**Primary Background - Near Black:** `#0D0D0D`
Use for: Most of the page

**Card/Section Background - Dark Charcoal:** `#1A1A1A`
Use for: Cards, panels, bordered sections

**Accent Background - Deep Slate:** `#1F2A34`
Use for: Feature highlight sections, hero overlay

**Primary Text - White:** `#FFFFFF`
Use for: Headlines, strong text

**Secondary Text - Warm Gray:** `#9CA3AF`
Use for: Body copy, descriptions, muted elements

**Muted Text - Dark Gray:** `#6B6B6B`
Use for: Labels, captions, small text

**Accent/Interactive - Warm White:** `#E8E4DF`
Use for: Buttons, borders, hover states

**Border Color - Subtle Gray:** `#2A2A2A`
Use for: Card borders, dividers, outlines

**Alert Amber:** `#C9A84C`
**Alert Red:** `#C45C5C`
**SMS User Bubble:** `#4A6274`

### CRITICAL CONSTRAINTS
**NO:**
- White backgrounds anywhere
- Light gray (#F4F5F7) sections
- Colorful gradients
- Drop shadows
- Rounded, bubbly SaaS aesthetics

### Typography

**Headlines:**
- Playfair Display (preferred) OR a refined serif
- UPPERCASE with generous letter-spacing (0.15-0.25em)
- Large, bold, architectural presence

**Body Text:**
- Inter (preferred)
- Regular weight, generous line-height (1.6-1.8)
- Warm gray (#9CA3AF) on dark backgrounds

**Small Labels/Overlines:**
- Inter, uppercase, letter-spacing 0.2em
- Muted color, 10-12px

**Rule:** Headlines are monumental. Body is quiet. Labels are whispered.

### Section Strategy
- **Hero:** Full-bleed restaurant photography with text overlay on dark
- **All other sections:** Dark background (#0D0D0D) with content
- **Variation comes from:** Typography scale, photography placement, bordered cards vs open layout
- **Rhythm:** Large photo sections alternate with typographic sections

### Button Style
**Primary CTA:**
- Border: 1px solid #E8E4DF (warm white outline)
- Text: #FFFFFF, uppercase, letter-spacing 0.15em, 13-14px
- Background: transparent
- Hover: Fill white, text goes dark
- **No rounded corners. No shadows. No gradients.**

### Photography
Use high-quality, dark, moody restaurant photography:
- Dimly lit dining rooms
- Close-ups of table settings
- Architectural details (pendant lights, bar counters, wood textures)
- All images should feel editorial and cinematic
- Desaturated, warm-tone grading

### Spacing & Layout
- **Very generous whitespace** (120-160px between sections)
- **Content max-width: 1200px** centered
- **2-column layouts** use asymmetric splits (40/60 or 30/70)
- **Cards use thin borders** (#2A2A2A), not fills or shadows
- **Icons: thin line, white or warm gray, 24-28px**
- ALL icons must be a single solid color (no multicolor, no gradients, no emoji-style)

### Mobile Responsiveness
- Single column stacking on mobile
- Headlines scale down (max 28px on mobile)
- Photography sections become shorter on mobile
- All content must be readable and well-spaced on 375px
- Full-width outlined buttons (48px height) on mobile
- 16px horizontal padding on mobile

---

## PAGE STRUCTURE (EXACT ORDER)

### 0. TOP NAV

**Layout:** Fixed or static, transparent over hero
- **Left:** "M" monogram + "Maitreo" wordmark in serif (Playfair Display), white text
- **Right:** "Start Free Trial" button - outlined (1px white border, transparent bg, white text, uppercase, letter-spaced)
- **Background:** Transparent (sits over the hero photography)
- **No other nav links.** Just logo + CTA. Clean and minimal.

---

### 1. HERO SECTION

**Background:** Full-bleed restaurant photography (moody, dimly lit fine dining room with pendant lights, bar seating, warm wood tones). Dark overlay (60-70% opacity black) to ensure text readability.

**Layout:** Two columns on desktop. Left: text content. Right: SMS interface panel.

**Left Column:**

**Headline (Serif, large, white text):**
```
Your Reputation Has a Maître d' Now.
```

**Subheadline (Sans-serif, warm gray #9CA3AF text):**
```
Maitreo monitors every review, responds in your voice, and alerts you instantly when something needs attention - all by SMS.
```

**Tension Statement (Sans-serif, smaller, muted gray):**
```
"Most restaurants discover reputation problems after guests stop coming. Maitreo notices the moment something feels off."
```

**CTA Button (outlined, white border, uppercase, letter-spaced):**
```
[ Start Free Trial ]
```

**Below button (small, muted text):**
```
7 days free. Cancel anytime before your trial ends.
No dashboard. No logins. Just intelligent alerts.
Works with Google, Yelp & TripAdvisor.
```

**Price Anchor (small, muted text #6B6B6B, below the supporting text):**
```
Less than the cost of one lost table per month.
```

**Supporting Bullet Row (checkmarks in white):**
```
✔ Monitors reviews every 15 minutes
✔ Auto-responds to positive feedback
✔ Instant alerts for negative reviews
✔ Detects patterns before ratings drop
✔ Weekly competitive intelligence
```

**Platform Logos (muted monochrome):**
```
Google Reviews · Yelp · TripAdvisor
```

**Micro-Interaction (small animated text cycling):**
```
Monitoring Google…
Monitoring Yelp…
Monitoring TripAdvisor…
All clear.
```

**Right Column - SMS Interface Panel:**

A tall, bordered card (#2A2A2A border, dark bg #1A1A1A) showing the Maitreo SMS exchange. Header: "M" monogram circle (#4A6274) + "Maitreo" label.

Messages animate sequentially with subtle fade-in and slight upward slide. Pause ~2 seconds between each message.

**All icons/indicators must be monochrome** - use white only. No colored emoji. Replace emoji with simple monochrome symbols (checkmark, warning triangle, alert circle).

**Message 1 - Auto-posted reply (plain, no border):**
```
✓ Auto-posted reply to 4.5★ review from Maria L. on Google
"Thank you, Maria! Evenings like yours are exactly why we do what we do here at The Pepper Room. We hope to welcome you back soon."
```

**Message 2 - New review alert (amber left border #C9A84C):**
```
⚠ New 2★ review from James R. on Yelp - mentions long wait for entrées despite reservation.
Draft reply:
"James, we appreciate the feedback. A 40-minute wait is not the standard we hold ourselves to at The Pepper Room. We're addressing this with our kitchen team directly. Please reach out to us so we can discuss further."
Reply YES to post, or send your own.
```

**Message 3 - User reply (#4A6274 background, white text, right-aligned):**
```
YES
```

**Message 4 - Confirmation:**
```
✓ Response posted to James's review.
```

**Message 5 - Urgent alert (red left border #C45C5C):**
```
⚠ URGENT: 2 negative reviews in 6 hours.
Both mention slow service. Possible operational issue tonight.

Suggested actions:
· Check kitchen timing and staffing levels
· Short-staff on expo? Consider pulling a manager
· Monitor next 2 hours for additional signals
```

**Animation loops** after completing the full sequence (with a longer pause before restarting).

---

### 2. "WHAT A MAÎTRE D' DOES" SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
A Great Maître d' Watches Everything. So Does Maitreo.
```

**3 Column Layout (thin line icons in white):**

**Column 1:**
Icon: Eye/watching symbol
**Watches the room**
→ monitors reviews everywhere

**Column 2:**
Icon: Hand raised/attention symbol
**Steps in when needed**
→ alerts you instantly

**Column 3:**
Icon: Clipboard/checklist symbol
**Maintains standards**
→ detects patterns over time

**Closing Line (centered, warm gray #9CA3AF):**
```
Maitreo brings front-of-house awareness to your online reputation.
```

---

### 3. CRISIS MODE PROTECTION SECTION

**Background:** Full-bleed restaurant photography (kitchen pass or empty dining room at night) with dark overlay.

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
When Something Goes Wrong, You'll Know Immediately
```

**Timeline Visual (vertical line with timestamps, white on dark):**
```
6:12pm - 2★ review mentions cold food

7:03pm - 1★ review mentions slow service

7:04pm - 🚨 Maitreo alerts you
         Possible operational issue detected.
```

**Supporting Line (Sans-serif, white):**
```
Before ratings drop. Before word spreads. Before bookings fall.
```

**Cost of Inaction (smaller text, warm gray #9CA3AF):**
```
Without Maitreo: You discover the problem Monday morning when your rating drops to 3.9★. 
By then, 500 potential guests have already seen it.
```

---

### 4. 3 PILLARS OVERVIEW SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
Three Pillars of Reputation Oversight
```

**3 Column Layout (bordered cards, thin #2A2A2A borders, separated by thin vertical dividers):**

**PILLAR 1 - Continuous Awareness**
Icon: Radar/monitoring symbol (thin line, white)
- Monitors every platform
- Pattern detection
- Staff mentions
- Photo tracking

**Badge:**
```
Checked every 15 minutes, 24/7
```

**Micro Example:**
```
"3 reviews mentioned 'slow service' this week"
```

**PILLAR 2 - Intelligent Response**
Icon: Message/chat symbol (thin line, white)
- Auto replies to positive
- Approval for negative
- Voice matching (learns from past replies or style prompt)
- Instant SMS control

**Micro Example:**
```
Auto-generated reply preview:
"Thank you, Maria! We're so glad you loved..."
```

**Microcopy:**
```
Learns your tone from past replies or a short style prompt during setup.
```

**PILLAR 3 - Strategic Intelligence**
Icon: Graph/trends symbol (thin line, white)
- Weekly report
- Competitor growth tracking
- Ranking changes
- Trend analysis

**Micro Example:**
```
Competitor gained +200% reviews this week
```

---

### 5. WEEKLY REPUTATION INTELLIGENCE BRIEFING SECTION

**Background:** Large restaurant photography (beautifully plated dish or sommelier pouring wine) with dark overlay on one side, content on the other.

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
Your Weekly Reputation Intelligence Briefing
```

**Subheadline (Sans-serif, warm gray):**
```
Everything that changed, everything that matters, and everything you should act on. Delivered every Sunday morning.
```

**Supporting Line (muted text #6B6B6B):**
```
The same awareness a great operator would build manually. Delivered automatically.
```

---

### **Digest Preview (Primary Visual) - Designed Newsletter Panel**

Design a large, polished newsletter-style panel inside a bordered card (#2A2A2A border, #1A1A1A background). Think Morning Brew or Stripe's annual reports. Not an email client, not plain text. A beautifully designed digest with visual hierarchy, data visualization, and clean layout.

**Panel header:**
- Top bar: "Maitreo Digest" left-aligned, "The Pepper Room - Week of Feb 3 - Feb 9" right-aligned, muted text
- All block headers in sans-serif (Inter), sentence case (not uppercase). No all-caps anywhere in the digest panel.
- Thin divider below header

**BLOCK 1 - This Week at a Glance**
Visual metric cards in a horizontal row. Each metric in its own mini card:
- **14** new reviews (small green arrow, +40%)
- **4.6** avg rating (small green arrow up from 4.4)
- **18 min** response time
- **Improving** sentiment (small upward trend line icon)
- **None** risk signals (small checkmark)

**BLOCK 2 - Patterns We Noticed**
Left-bordered insight cards (thin white left border on each):
- "Slow service" in 3 reviews (up from 1 last week)
- Maria mentioned positively 5 times
- Outdoor seating praised repeatedly
- Noise complaints increased Friday nights

Each card should feel like a distinct insight, not a bullet list.

**BLOCK 3 - Competitor Watch**
Visual comparison layout:
- Miami Chop House: big bold "+12 reviews" with a small bar chart showing spike vs typical average of 4. Red "Growth anomaly" tag.
- Harbor Grill: "4.5 → 4.2" with a small downward arrow visualization
- Insight callout card: "Competitors praised for fast lunch service"

This block should feel strategic and data-rich.

**BLOCK 4 - Recommended Actions**
Clean checklist with checkbox styling:
- ☐ Investigate Friday dinner service timing
- ☐ Recognize Maria for guest experience impact
- ☐ Monitor Miami Chop House next 2 weeks
- ☐ Encourage guests to post food photos

Each item on its own line with generous spacing.

---

**Section Closing Line (centered, bold, white):**
```
Most restaurants react to reviews. Maitreo helps you anticipate trends.
```

**Experience Framing (small, centered, muted text #6B6B6B):**
```
Coffee in hand. Clear perspective. Confident decisions for the week ahead.
```

---

### 6. COMPETITOR INTELLIGENCE SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
Know What's Happening Across the Street
```

**Explain Why This Matters (Sans-serif, warm gray):**
- Competitor momentum
- Sudden popularity spikes
- Service trends
- Positioning changes

**Example Visual (bordered card, prominent):**
```
Miami Chop House: +12 reviews this week
Typical weekly average: 4
Growth anomaly detected
```

**Closing Line (centered, bold, white):**
```
Most restaurants only watch themselves. Maitreo watches the market.
```

---

### 7. DASHBOARD VS SMS VISUAL CONTRAST SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white, very large):**
```
Most Tools Give You Dashboards. Maitreo Sends a Text.
```

**Subheadline (Sans-serif, warm gray):**
```
One requires constant monitoring. The other speaks only when it matters.
```

---

### **Visual Layout (Side-by-Side Contrast)**

**Optional small divider label above both visuals:**
```
The Old Way → The Maitreo Way
```

---

**LEFT SIDE - Complex Dashboard**

Create a visually dense, cognitively heavy mock interface showing:
- Multiple charts and graphs
- Platform tabs (Google, Yelp, TripAdvisor)
- Notification badges
- Filters and dropdowns
- Side navigation
- Data tables
- Sentiment analytics

**The dashboard should feel:**
- Busy
- Time-consuming
- Overwhelming
- Software-heavy

**Visual treatment:** Fully monochrome. All grays. Dense. Overwhelming.

**Caption below dashboard:**
```
"Another dashboard. Another login. Another thing to check."
```

**"VS" divider:** Small bordered circle between the dashboard and SMS sides with "VS" inside. White border circle with white text.

---

**RIGHT SIDE - Maitreo SMS**

Bordered card (#2A2A2A border, #1A1A1A bg). "M" monogram at top. Minimal phone-style frame (thin outline only, no notch, no status bar, no device chrome):

```
[Maitreo]
⚠ New 2★ Yelp review from James R.
Mentions long wait for entrées.
Draft reply: "James, we appreciate the feedback. A 40-minute wait is not the standard we hold ourselves to at The Pepper Room. We're addressing this with our kitchen team directly. Please reach out to us so we can discuss further."
Reply YES to post, or send your own.

[You]
YES

[Maitreo]
✓ Posted.
```

Same styling as hero SMS panel. White Maitreo messages, #4A6274 user bubble, amber left border on alert.

**Caption below SMS:**
```
"No dashboard. No analysis. Just clarity."
```

---

**Closing Line (centered, bold, white):**
```
Stop checking dashboards. Let Maitreo check everything for you.
```

---

### 8. COMPARISON TABLE SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
How Reputation Is Managed
```

**2-Column Comparison Table (thin borders #2A2A2A):**

| **Without Maitreo** | **With Maitreo** |
|---------------------|------------------|
| Check 3 platforms separately, 2-3x per week | All platforms monitored every 15 minutes |
| React after damage | Early warning alerts |
| Guess what's wrong | Pattern detection |
| No competitor insight | Market intelligence |
| Time-consuming | Automatic |

Left column: muted gray text. Right column: white/brighter text.

---

### 9. PRICING SECTION

**Background:** Dark (#0D0D0D)

**Overline (uppercase, letter-spaced, muted):**
```
Simple Pricing
```

**ROI Framing Line (centered, bold, white):**
```
Costs less than one lost table per week.
```

**Price Display (serif, very large, white):**
```
$99/month per location
```

**Included Features (checkmarks in white, 2-column grid on desktop, single column mobile):**
- All 3 platforms included
- Unlimited reviews
- AI-powered replies
- Weekly competitive intelligence
- SMS alerts + email digest
- 7-day free trial
- Cancel anytime

**CTA Button (outlined, white border, uppercase, letter-spaced):**
```
[ Start Free Trial ]
```

---

### 9.5. FIRST WEEK EXPERIENCE SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
What Happens After You Start
```

**Step Sequence (4 steps, numbered in large serif, step text in sans-serif):**

**Step 1:**
```
Enter restaurant name and address
```

**Step 2:**
```
Connect review platforms
(simple OAuth links sent to your email)
```

**Step 3:**
```
Maitreo begins monitoring within 24 hours
```

**Step 4:**
```
First alert arrives when something needs attention
```

---

### 10. TESTIMONIALS SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
Proof of Impact
```

**3 bordered testimonial cards (#2A2A2A border):**

**Testimonial 1:**
```
"We caught a service issue on a Saturday night before it affected our rating. Fixed it immediately."
— Marco T., The Pepper Room, Miami
```

**Testimonial 2:**
```
"We didn't realize a new competitor was gaining traction until Maitreo flagged it."
— Sarah K., Harbor Grill, Seattle
```

**Testimonial 3:**
```
"Response time dropped from hours to minutes. Our rating went from 4.2 to 4.6 in two months."
— David L., Tuscany Kitchen, San Francisco
```

Attribution in uppercase, letter-spaced, muted.

---

### 11. FAQ SECTION

**Background:** Dark (#0D0D0D)

**Section Headline (Serif, uppercase, letter-spaced, white):**
```
Common Questions
```

**Accordion or clean Q&A format. Questions in white, answers in warm gray #9CA3AF.**

**Q: Will replies sound robotic?**
A: No. We learn your voice during onboarding. Every reply is customized to your brand. You approve negative responses before they post.

**Q: What if I'm closed on Sundays?**
A: The digest arrives Sunday 9am, perfect for planning your week. If you'd prefer a different day, just let us know.

**Q: How long does setup take?**
A: 2 minutes. Enter your restaurant name and address. We find your listings and send simple connection links. You're live within 24 hours.

**Q: Can I cancel anytime?**
A: Yes. Month-to-month, no long-term contracts.

**Q: What platforms do you monitor?**
A: Google Reviews, Yelp, and TripAdvisor - all in one system.

**Q: Do you post reviews without my approval?**
A: We auto-post positive reviews (4-5 stars). Negative reviews always require your approval via SMS before posting.

**Q: How do I cancel?**
A: Reply CANCEL to any Maitreo text, or use the manage subscription link in your weekly digest. No hoops, no calls. Instant.

---

### 12. FINAL CTA SECTION

**Background:** Restaurant photography (moody bar scene, ambient lighting) with dark overlay.

**Headline (Serif, uppercase, letter-spaced, white, large):**
```
Your Maître d' Is Ready for Service.
```

**Subtext (Sans-serif, muted warm gray):**
```
Continuous reputation monitoring begins the moment you start.
```

**CTA Button (outlined, white border, uppercase, letter-spaced, large):**
```
[ Begin Service ]
```

**Supporting Text (small, muted):**
```
No dashboard. No setup complexity. Just attentive oversight.
```

---

### 13. FOOTER

**Minimal. Dark.**
```
MAITREO © 2025          PRIVACY    TERMS
```

---

## TRUST MICROCOPY (SPRINKLE THROUGHOUT)

Add these subtle reassurance lines in appropriate sections:
- Replies match your voice
- You control negative responses
- Silent when everything is running smoothly
- Learns your tone from past replies or a short style prompt during setup

---

## EMOTIONAL GOAL

Visitors should feel:
> "My reputation is being professionally attended to."

NOT:
> "I'm signing up for another software tool."

---

## CTA REPETITION RULE

**DO NOT REMOVE THIS RULE.**

CTAs appear in these locations:
1. **After Hero** - Primary CTA above fold
2. **After Pricing (Section 9)** - Convert on price decision
3. **Final Section (Section 12)** - Last chance conversion

All CTAs use outlined style: white border, transparent fill, uppercase, letter-spaced.

---

## DESIGN PRINCIPLES SUMMARY

1. **Dark background everywhere** - No white sections. No light gray. Dark, dark, dark.
2. **Photography is key** - 2-3 full-bleed restaurant photos break up the typography sections
3. **Uppercase serif headlines** with generous letter-spacing = architectural presence
4. **Bordered cards** (thin #2A2A2A borders) instead of filled/shadowed cards
5. **Outlined buttons** (white border, transparent fill) not filled buttons
6. **SMS shown as structured intelligence** in bordered panels, not casual chat bubbles
7. **Overlines/labels** above sections (uppercase, letter-spaced, muted)
8. **Generous whitespace** (120-160px between sections minimum)
9. **Typography does the heavy lifting** - minimal decorative elements
10. **Monochrome** except amber/red for alert severity indicators
11. **All icons: thin-line, single solid color (white), clearly visible**

---

## FINAL REMINDER

**CRITICAL:** Follow these specifications EXACTLY. Use the exact copy provided. Use the exact colors specified. Follow the exact page structure. Do not add sections, change copy, or reinterpret the visual direction. Stay aligned to what is written above.

This should feel like a luxury hospitality brand's website, not a technology product page. Cinematic. Editorial. Precise.

No em dashes anywhere. No bubbly SaaS aesthetic. No white or light backgrounds.

Generate a landing page that makes restaurant owners feel like they're being offered membership to an exclusive intelligence service for their reputation.
