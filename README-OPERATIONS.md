# Restaurant SaaS - Operations Documentation

**Complete operational readiness guide for pilot program success**

---

## 📚 Documentation Index

### Core Documents

1. **[OPERATIONS.md](OPERATIONS.md)** (1,645 lines) - *Master runbook*
   - Complete operational procedures
   - Onboarding checklist
   - Troubleshooting guides
   - Monitoring setup
   - Quality assurance
   - Success metrics

2. **[OPERATIONS-QUICKREF.md](OPERATIONS-QUICKREF.md)** - *Daily reference card*
   - Print-friendly quick reference
   - Common commands
   - Emergency contacts
   - Key SQL queries

3. **[PILOT-TESTING-CHECKLIST.md](PILOT-TESTING-CHECKLIST.md)** - *Pre-launch template*
   - Fillable testing checklist
   - Sign-off form
   - Post-launch monitoring

---

## 🚀 Quick Start

### New to Operations?

**Day 1: Setup**
1. Read OPERATIONS.md sections 1-2 (Onboarding & Runbook)
2. Setup monitoring dashboard (section 3)
3. Run health check: `./scripts/check-health.sh`

**Day 2: Learn the System**
1. Review QA procedures (section 4)
2. Understand success metrics (section 5)
3. Bookmark OPERATIONS-QUICKREF.md

**Day 3: Practice**
1. Run test onboarding with dummy restaurant
2. Simulate error scenarios
3. Generate first pilot report: `./scripts/pilot-report.sh`

---

## 🛠️ Scripts

Located in `scripts/`:

- **`check-health.sh`** - Daily health check (run every morning)
- **`pilot-report.sh`** - Weekly metrics report (run Mondays)

Make executable:
```bash
chmod +x scripts/*.sh
```

---

## 📊 Monitoring

### Daily Checklist (09:00 AM)

```bash
cd ~/restaurant-saas
./scripts/check-health.sh
```

Look for:
- ✅ All restaurants ingested in 24h
- ✅ Email delivery >95%
- ✅ No job failures
- ✅ No overdue drafts

### Weekly Report (Mondays)

```bash
./scripts/pilot-report.sh
```

Share with team for visibility into pilot health.

### Dashboard Options

1. **CLI Dashboard** (fastest)
   - Run `check-health.sh` from terminal
   
2. **SQL Queries** (most flexible)
   - Use views in OPERATIONS.md section 3.1
   - Run in Supabase dashboard or `psql`
   
3. **HTML Dashboard** (best for non-technical team)
   - Setup instructions in OPERATIONS.md section 3.2
   - Host on Vercel/Netlify

---

## 🎯 Success Metrics at a Glance

| Metric | Target | Current |
|--------|--------|---------|
| Ingestion success rate | >98% | `./scripts/check-health.sh` |
| Email delivery rate | >97% | See weekly report |
| Draft approval rate | >80% | See weekly report |
| Response time | <2 hours | See weekly report |
| 30-day retention | >90% | See weekly report |

---

## 🔥 Common Issues & Quick Fixes

### Restaurant not getting reviews
```bash
npm run ingestion -- --restaurant-id=X --force
```

### Email bounced
```sql
-- Check reason
SELECT error_message FROM email_logs WHERE id=X;

-- Mark invalid if hard bounce
UPDATE restaurants SET contact_email_status='invalid' WHERE id=X;
```

### Newsletter didn't send
```bash
npm run newsletter:send -- --newsletter-id=X --force
```

### Reply sounds wrong
```bash
npm run replies:regenerate -- --draft-id=X
```

**For more, see:** OPERATIONS.md section 2.2-2.4

---

## 📋 Pilot Onboarding Process

### 5-Step Onboarding

1. **Collect Info** (T-3 days)
   - Send intake form
   - Verify platform access

2. **Setup Account** (Day 0)
   - Create database records
   - Configure settings

3. **Test Everything** (T-1 day)
   - Use PILOT-TESTING-CHECKLIST.md
   - Get owner sign-off

4. **Launch** (Day 0)
   - Send welcome email
   - Enable automation

5. **Monitor** (Days 1-7)
   - Daily checks
   - Day 3: first check-in
   - Day 7: week 1 review

**Full details:** OPERATIONS.md section 1

---

## 🚨 Emergency Procedures

### Severity Levels

| Level | Response Time | Contact |
|-------|---------------|---------|
| **P0** - System down | <15 min | Primary on-call |
| **P1** - Multiple failures | <1 hour | Primary on-call |
| **P2** - Single restaurant | <4 hours | During business hours |
| **P3** - Minor issue | <24 hours | Next business day |

### Incident Response

1. **Assess** - Check server, database, logs
2. **Communicate** - Notify team and affected customers
3. **Fix** - Follow runbook procedures
4. **Verify** - Test all systems
5. **Document** - Post-mortem within 24h

**Full runbook:** OPERATIONS.md section 6

---

## 🧪 Quality Assurance

### Testing Requirements

Before any pilot goes live:

- [ ] All 8 tests in PILOT-TESTING-CHECKLIST.md passed
- [ ] Edge cases handled (no reviews, all 1-star, etc.)
- [ ] Email deliverability score >8/10
- [ ] Restaurant owner sign-off

### Monthly QA

- Run reply quality tests
- Validate newsletter accuracy
- Check email deliverability
- Review edge case handling

**Test plans:** OPERATIONS.md section 4

---

## 📞 Support Contacts

### Internal Team
- **Primary On-Call:** [Name] - [Phone]
- **Backup:** [Name] - [Phone]
- **Engineering:** [Name] - [Phone]

### Vendors
- **Supabase:** support@supabase.com | https://status.supabase.com
- **Resend:** support@resend.com | https://resend.com/status
- **OpenAI:** help.openai.com | https://status.openai.com

---

## 🔄 Continuous Improvement

### Weekly Review
- Run pilot report
- Identify bottlenecks
- Update procedures

### Monthly Review
- Analyze success metrics
- Customer feedback themes
- Process improvements

### Incident Reviews
- Root cause analysis
- Prevention measures
- Documentation updates

---

## 📚 Additional Resources

### Documentation Standards
- Update OPERATIONS.md when procedures change
- Keep QUICKREF.md in sync
- Document all incidents

### Training Materials
- Onboarding deck (create in Notion/Google Slides)
- Video walkthroughs (Loom)
- FAQ document (evolve from support tickets)

### Feedback Loops
- Post-incident reviews
- Pilot retrospectives
- Customer satisfaction surveys

---

## ✅ Pre-Pilot Checklist

Before accepting first pilot:

- [ ] All scripts tested and working
- [ ] Monitoring dashboard accessible
- [ ] Database views created (OPERATIONS.md section 3.1)
- [ ] Email deliverability tested
- [ ] Emergency contacts verified
- [ ] Runbook procedures validated
- [ ] Team trained on operations

---

## 📈 Roadmap

### Phase 1: Manual Operations (Current)
- Manual onboarding
- Daily health checks
- Weekly reports
- Support via email/Slack

### Phase 2: Semi-Automated (Month 2)
- Automated health alerts
- Self-service dashboard for restaurants
- Automated weekly reports
- Chatbot support (tier 1)

### Phase 3: Fully Automated (Month 3+)
- Self-service onboarding
- Predictive alerting
- AI-powered optimization
- Zero-touch operations

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-10 | Initial creation - Complete operations documentation |

---

## 🎓 Philosophy

**Our operations principles:**

1. **Fast response > Perfect solution** - Fix quickly, iterate later
2. **Transparency builds trust** - Communicate openly with customers
3. **Document everything** - Future you will thank present you
4. **Automate the repetitive** - Humans for judgment, machines for routine
5. **Learn from every incident** - Failures are lessons in disguise

---

## 🚦 Getting Started Checklist

**I'm ready to run operations when:**

- [ ] I've read OPERATIONS.md cover to cover
- [ ] I've run check-health.sh successfully
- [ ] I've completed a test onboarding (dummy data)
- [ ] I can explain all 5 success metrics
- [ ] I know who to call for P0/P1/P2/P3 incidents
- [ ] I've bookmarked OPERATIONS-QUICKREF.md
- [ ] I understand the incident response process
- [ ] I've run the pilot-report.sh script

**Sign-off:** _______________ **Date:** _______________

---

## 💡 Tips from the Field

> "Run health checks BEFORE your morning coffee. Catch issues early."

> "When in doubt, check the logs. They never lie."

> "A 5-minute check-in call prevents a 2-hour emergency fix."

> "Document the weird stuff. That's what breaks at 2am."

> "Good operations is invisible. Great operations is boring (in a good way)."

---

**Questions?** Consult OPERATIONS.md or escalate to team lead.

**Feedback?** Update these docs and commit your improvements!

---

*Built with care for pilot success. Good luck! 🍀*
