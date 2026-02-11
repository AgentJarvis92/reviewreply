# OPERATIONS QUICK REFERENCE CARD

**Print this and keep at your desk** 📋

---

## DAILY CHECKLIST (09:00 AM)

```bash
# Run health check
cd ~/restaurant-saas
./scripts/check-health.sh
```

Look for:
- ✅ All restaurants ingested in 24h
- ✅ Email delivery rate >95%
- ✅ No job failures
- ✅ No pending drafts >48h old

---

## COMMON ISSUES - INSTANT FIXES

### "Restaurant not getting reviews"
```bash
npm run ingestion -- --restaurant-id=X --force
```

### "Email bounced"
```sql
-- Check bounce reason
SELECT error_message FROM email_logs WHERE id=X;

-- If hard bounce, mark email invalid
UPDATE restaurants SET contact_email_status='invalid' WHERE id=X;
```

### "Newsletter didn't send"
```bash
# Check status
psql $DATABASE_URL -c "SELECT * FROM newsletters WHERE id=X;"

# Resend
npm run newsletter:send -- --newsletter-id=X --force
```

### "Reply sounds wrong"
```bash
# Regenerate with current settings
npm run replies:regenerate -- --draft-id=X
```

---

## EMERGENCY CONTACTS

| Issue | Contact |
|-------|---------|
| System down | [Primary On-Call] |
| Database issue | [DBA/Backend] |
| Email delivery | support@resend.com |
| API quota | [Accounts person] |

---

## KEY SQL QUERIES

### Restaurant health
```sql
SELECT * FROM v_restaurant_status WHERE email_errors_7d > 0;
```

### Email delivery issues
```sql
SELECT * FROM v_email_health WHERE delivery_rate < 95;
```

### Recent failures
```sql
SELECT * FROM job_logs 
WHERE status='failed' AND created_at > NOW() - INTERVAL '24 hours';
```

### Pending approvals
```sql
SELECT r.name, COUNT(*) 
FROM draft_replies dr 
JOIN restaurants r ON r.id=dr.restaurant_id 
WHERE dr.status='pending_approval' 
GROUP BY r.name;
```

---

## SEVERITY LEVELS

| Level | Response | Example |
|-------|----------|---------|
| **P0** | <15 min | System down |
| **P1** | <1 hour | Multiple failures |
| **P2** | <4 hours | Single restaurant issue |
| **P3** | <24 hours | Minor bug |

---

## USEFUL COMMANDS

```bash
# Restart everything
systemctl restart app

# View live errors
tail -f /var/log/app.log | grep ERROR

# Check cron jobs
crontab -l

# Database backup
pg_dump $DATABASE_URL > backup-$(date +%Y%m%d).sql

# Test email delivery
npm run email:test -- --to=your@email.com

# Check API status
curl https://status.openai.com
curl https://status.supabase.com
curl https://resend.com/status
```

---

## SUCCESS METRICS AT A GLANCE

| Metric | Target |
|--------|--------|
| Ingestion success rate | >98% |
| Email delivery rate | >97% |
| Draft approval rate | >80% |
| Newsletter feedback | >4.0/5 |
| 30-day retention | >90% |
| Response time | <2 hours |

---

## PILOT ONBOARDING - 5 STEPS

1. **Collect info** - Send intake form
2. **Setup account** - Run SQL scripts
3. **Test everything** - Dry runs + approval
4. **Send welcome email** - Training link
5. **Schedule check-ins** - Day 3, 7, 14, 28

---

## RED FLAGS 🚨

Take immediate action if you see:
- ❌ No ingestion in 24h
- ❌ Email bounce rate >5%
- ❌ 3+ failures same restaurant
- ❌ OpenAI quota errors
- ❌ Customer complaint about tone

---

## WHEN IN DOUBT

1. Check the logs
2. Try the manual command
3. Consult OPERATIONS.md (section 2.2)
4. Escalate if not resolved in 1 hour

**Remember:** Fast response > perfect solution

---

*Last updated: 2026-02-10*
