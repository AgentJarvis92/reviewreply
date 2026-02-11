# PILOT TESTING CHECKLIST

**Restaurant:** _______________  
**Tester:** _______________  
**Date:** _______________  
**Status:** ☐ Draft | ☐ In Progress | ☐ Complete

---

## PRE-LAUNCH TESTING

### ✅ 1. Account Setup

- [ ] Restaurant record created in database
- [ ] All contact information verified (email, phone, address)
- [ ] Google/Yelp/TripAdvisor URLs validated
- [ ] Brand voice settings configured
- [ ] Competitors added (minimum 2)
- [ ] Email configuration complete (sender name, reply-to, schedule)

**Notes:**
```



```

---

### ✅ 2. Review Ingestion Test

**Test Command:**
```bash
npm run ingestion -- --restaurant-id=<ID> --dry-run
```

**Verification:**
- [ ] Reviews fetched successfully from Google
- [ ] Reviews fetched successfully from Yelp
- [ ] Review data complete (rating, text, date, author)
- [ ] No duplicate reviews created
- [ ] Proper error handling (rate limits, invalid credentials)
- [ ] Reviews appear in database with correct restaurant_id

**Sample Output:**
```
[Paste output here]




```

**Issues Found:**
```



```

---

### ✅ 3. Reply Generation Test

**Test Reviews (try all rating levels):**

| Rating | Review Text | Reviewer | Generated Reply Quality |
|--------|-------------|----------|------------------------|
| 5★ | "Best meal ever!" | Sarah J. | ☐ Pass ☐ Fail ☐ Needs tweaking |
| 4★ | "Good food, slow service" | Mike D. | ☐ Pass ☐ Fail ☐ Needs tweaking |
| 3★ | "Okay experience" | Lisa K. | ☐ Pass ☐ Fail ☐ Needs tweaking |
| 2★ | "Not impressed" | Tom R. | ☐ Pass ☐ Fail ☐ Needs tweaking |
| 1★ | "Terrible, won't return" | Amy S. | ☐ Pass ☐ Fail ☐ Needs tweaking |

**Reply Quality Checklist (for each reply):**
- [ ] Personalized with reviewer name
- [ ] Tone matches restaurant brand
- [ ] Length appropriate (50-150 words)
- [ ] No generic templates ("Thank you for your feedback")
- [ ] Specific to review content
- [ ] Grammar and spelling correct
- [ ] Professional yet warm
- [ ] Call-to-action included (for positive reviews)
- [ ] Resolution offered (for negative reviews)

**Sample Generated Reply (5-star):**
```
[Paste reply here]




```

**Sample Generated Reply (1-star):**
```
[Paste reply here]




```

**Owner Feedback:**
> "Does this sound like your voice? Any phrases to add/avoid?"

```



```

---

### ✅ 4. Email Deliverability Test

**Welcome Email Test:**
```bash
npm run email:test -- --restaurant-id=<ID> --type=welcome
```

**Verification:**
- [ ] Email arrives within 60 seconds
- [ ] Sender name displays correctly
- [ ] Subject line appropriate
- [ ] Reply-to address correct
- [ ] Email lands in inbox (NOT spam/promotions)
- [ ] All images load
- [ ] All links work
- [ ] Unsubscribe link functions
- [ ] Mobile responsive (test on phone)
- [ ] Looks good in Gmail
- [ ] Looks good in Outlook
- [ ] Looks good in Apple Mail

**Mail-Tester.com Score:** ___/10

**Issues Found:**
```



```

---

### ✅ 5. Newsletter Generation Test

**Test Command:**
```bash
npm run newsletter -- --restaurant-id=<ID> --dry-run
```

**Verification:**
- [ ] Review summary accurate (count, average rating)
- [ ] Sentiment analysis reasonable
- [ ] Competitor data fetched and displayed
- [ ] Charts/visualizations render
- [ ] No "undefined" or "null" in content
- [ ] Formatting clean and professional
- [ ] Call-to-action clear
- [ ] Mobile responsive

**Newsletter Preview Link:** _______________

**Owner Feedback:**
> "Is this useful? What would you change?"

```



```

---

### ✅ 6. Edge Case Testing

- [ ] **No reviews this week**
  - Newsletter generates gracefully
  - Message: "No new reviews this week"
  - Still includes competitor insights
  
- [ ] **All 5-star reviews**
  - Celebratory tone
  - No errors in sentiment analysis
  
- [ ] **All 1-star reviews**
  - Supportive, action-oriented tone
  - Doesn't feel discouraging
  
- [ ] **Competitor has no data**
  - Section gracefully omitted OR shows "Data unavailable"
  - No crashes or errors
  
- [ ] **Special characters in review** (emoji, quotes, apostrophes)
  - Reply generates correctly
  - No encoding issues
  
- [ ] **Very long review** (>500 words)
  - Reply summarizes key points
  - Doesn't just repeat everything
  
- [ ] **Empty review** (just star rating, no text)
  - Generates appropriate generic reply
  - Still feels personal

**Edge Cases Passed:** ___/7

**Notes:**
```



```

---

### ✅ 7. End-to-End Flow Test

**Simulate complete workflow:**

1. [ ] New review posted on Google/Yelp
2. [ ] Ingestion job runs (or manual trigger)
3. [ ] Review appears in database
4. [ ] Draft reply generated within 2 hours
5. [ ] Draft visible in dashboard (or sent to restaurant)
6. [ ] Restaurant approves/edits reply
7. [ ] Reply posted to platform
8. [ ] Confirmation logged

**Timeline Test:**
- Review posted at: _______________
- Ingested at: _______________
- Draft generated at: _______________
- Draft approved at: _______________
- Reply posted at: _______________
- **Total time:** _____ hours/minutes

**Target:** <2 hours from review to draft

---

### ✅ 8. Error Recovery Test

**Test failure scenarios:**

- [ ] **Invalid Google API credentials**
  - Error logged properly
  - Restaurant notified (if critical)
  - Recovery process works
  
- [ ] **Email bounces (simulate with invalid address)**
  - Bounce detected
  - Marked in database
  - Follow-up process triggered
  
- [ ] **OpenAI API error (simulate quota issue)**
  - Fallback behavior works
  - Error doesn't break entire system
  - Retry logic functions
  
- [ ] **Database connection lost**
  - Graceful error handling
  - No data corruption
  - Automatic reconnection

**Recovery Test Results:**
```



```

---

## SIGN-OFF

### Restaurant Owner Approval

"I have reviewed the test replies, newsletter preview, and email samples. I approve the system to go live."

**Restaurant Owner:** _______________ **Date:** _______________

**Signature:** _______________

---

### Operations Team Sign-Off

"All tests passed. System is ready for production."

**Tested By:** _______________ **Date:** _______________

**Approved By:** _______________ **Date:** _______________

---

## GO-LIVE CHECKLIST

- [ ] All tests passed
- [ ] Restaurant owner trained on dashboard
- [ ] Welcome email sent
- [ ] Monitoring alerts configured
- [ ] Support contact information shared
- [ ] Next check-in scheduled (Day 3)
- [ ] Ingestion cron job enabled
- [ ] Newsletter scheduled

**Go-Live Date:** _______________

---

## POST-LAUNCH MONITORING (First 7 Days)

| Day | Check Performed | Status | Issues Found |
|-----|----------------|--------|--------------|
| 1 | Ingestion working? | ☐ ✅ ☐ ⚠️ ☐ ❌ | |
| 2 | Drafts generating? | ☐ ✅ ☐ ⚠️ ☐ ❌ | |
| 3 | Check-in call | ☐ ✅ ☐ ⚠️ ☐ ❌ | |
| 4 | Email delivery OK? | ☐ ✅ ☐ ⚠️ ☐ ❌ | |
| 5 | Newsletter sent? | ☐ ✅ ☐ ⚠️ ☐ ❌ | |
| 6 | Owner feedback? | ☐ ✅ ☐ ⚠️ ☐ ❌ | |
| 7 | Week 1 review call | ☐ ✅ ☐ ⚠️ ☐ ❌ | |

---

## LESSONS LEARNED

**What went well:**
```



```

**What could be improved:**
```



```

**Action items for next pilot:**
```



```

---

**Template Version:** 1.0  
**Last Updated:** 2026-02-10
