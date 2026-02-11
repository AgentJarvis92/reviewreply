#!/bin/bash
# Restaurant SaaS - Weekly Pilot Success Report
# Tracks key metrics for pilot program health

set -e

echo "==========================================="
echo "📈 WEEKLY PILOT SUCCESS REPORT"
echo "==========================================="
echo "Week of: $(date -v-7d '+%Y-%m-%d') to $(date '+%Y-%m-%d')"
echo "Generated: $(date)"
echo ""

# Load database URL
if [ -f ~/.openclaw/workspace/.env ]; then
    source ~/.openclaw/workspace/.env
elif [ -f ~/restaurant-saas/.env ]; then
    source ~/restaurant-saas/.env
elif [ -f ~/restaurant-saas/backend/.env ]; then
    source ~/restaurant-saas/backend/.env
fi

if [ -z "$DATABASE_URL" ]; then
    echo "❌ Error: DATABASE_URL not set"
    exit 1
fi

echo "==========================================="
echo "🔧 TECHNICAL METRICS"
echo "==========================================="
echo ""

echo "Ingestion Success Rate:"
psql "$DATABASE_URL" -c "
  SELECT 
    COUNT(*) as total_jobs,
    COUNT(CASE WHEN status = 'success' THEN 1 END) as successful,
    ROUND(100.0 * COUNT(CASE WHEN status = 'success' THEN 1 END) / NULLIF(COUNT(*), 0), 2) || '%' as success_rate
  FROM job_logs 
  WHERE job_type = 'ingestion' AND created_at > NOW() - INTERVAL '7 days';" 2>/dev/null || echo "No data"

echo ""
echo "Email Delivery Rate:"
psql "$DATABASE_URL" -c "
  SELECT 
    COUNT(*) as total_sent,
    COUNT(CASE WHEN status = 'delivered' THEN 1 END) as delivered,
    COUNT(CASE WHEN status = 'bounced' OR status = 'failed' THEN 1 END) as failed,
    ROUND(100.0 * COUNT(CASE WHEN status = 'delivered' THEN 1 END) / NULLIF(COUNT(*), 0), 2) || '%' as delivery_rate
  FROM email_logs 
  WHERE created_at > NOW() - INTERVAL '7 days';" 2>/dev/null || echo "No data"

echo ""
echo "Average Response Time (review → draft):"
psql "$DATABASE_URL" -c "
  SELECT 
    ROUND(AVG(EXTRACT(EPOCH FROM (dr.created_at - r.review_date))) / 3600, 1) || ' hours' as avg_response_time,
    MIN(EXTRACT(EPOCH FROM (dr.created_at - r.review_date))) / 60 || ' min' as fastest,
    MAX(EXTRACT(EPOCH FROM (dr.created_at - r.review_date))) / 3600 || ' hrs' as slowest
  FROM draft_replies dr
  JOIN reviews r ON r.id = dr.review_id
  WHERE dr.created_at > NOW() - INTERVAL '7 days';" 2>/dev/null || echo "No data"

echo ""
echo "==========================================="
echo "😊 CUSTOMER SATISFACTION"
echo "==========================================="
echo ""

echo "Draft Approval Rate (by restaurant):"
psql "$DATABASE_URL" -c "
  SELECT 
    r.name,
    COUNT(*) as total_drafts,
    COUNT(CASE WHEN dr.status = 'approved' AND dr.edited = false THEN 1 END) as approved_as_is,
    ROUND(100.0 * COUNT(CASE WHEN dr.status = 'approved' AND dr.edited = false THEN 1 END) / NULLIF(COUNT(*), 0), 2) || '%' as approval_rate
  FROM draft_replies dr
  JOIN restaurants r ON r.id = dr.restaurant_id
  WHERE dr.created_at > NOW() - INTERVAL '7 days'
  GROUP BY r.name
  ORDER BY approval_rate DESC;" 2>/dev/null || echo "No data"

echo ""
echo "Newsletter Feedback (if available):"
psql "$DATABASE_URL" -c "
  SELECT 
    COUNT(*) as responses,
    ROUND(AVG(rating), 2) as avg_rating,
    COUNT(CASE WHEN rating >= 4 THEN 1 END) as positive,
    COUNT(CASE WHEN rating <= 2 THEN 1 END) as negative
  FROM newsletter_feedback
  WHERE created_at > NOW() - INTERVAL '7 days';" 2>/dev/null || echo "No newsletter feedback data yet"

echo ""
echo "==========================================="
echo "💼 BUSINESS METRICS"
echo "==========================================="
echo ""

echo "Active Pilots:"
psql "$DATABASE_URL" -c "
  SELECT 
    COUNT(*) as total_active,
    COUNT(CASE WHEN created_at > NOW() - INTERVAL '7 days' THEN 1 END) as new_this_week,
    COUNT(CASE WHEN created_at > NOW() - INTERVAL '30 days' THEN 1 END) as new_this_month
  FROM restaurants 
  WHERE status = 'active';" 2>/dev/null || echo "No data"

echo ""
echo "Retention by Cohort:"
psql "$DATABASE_URL" -c "
  SELECT 
    CASE 
      WHEN NOW() - created_at < INTERVAL '30 days' THEN '<30 days'
      WHEN NOW() - created_at < INTERVAL '60 days' THEN '30-60 days'
      WHEN NOW() - created_at < INTERVAL '90 days' THEN '60-90 days'
      ELSE '>90 days'
    END as cohort,
    COUNT(*) as total,
    COUNT(CASE WHEN status = 'active' THEN 1 END) as still_active,
    ROUND(100.0 * COUNT(CASE WHEN status = 'active' THEN 1 END) / NULLIF(COUNT(*), 0), 2) || '%' as retention_rate
  FROM restaurants
  GROUP BY cohort
  ORDER BY 
    CASE 
      WHEN cohort = '<30 days' THEN 1
      WHEN cohort = '30-60 days' THEN 2
      WHEN cohort = '60-90 days' THEN 3
      ELSE 4
    END;" 2>/dev/null || echo "No data"

echo ""
echo "Referrals (this week):"
psql "$DATABASE_URL" -c "
  SELECT 
    COUNT(*) as total_referrals,
    COUNT(CASE WHEN status = 'signed_up' THEN 1 END) as converted,
    COUNT(CASE WHEN status = 'pending' OR status = 'contacted' THEN 1 END) as in_progress
  FROM referrals
  WHERE created_at > NOW() - INTERVAL '7 days';" 2>/dev/null || echo "No referral tracking yet"

echo ""
echo "==========================================="
echo "🎯 TARGET COMPARISON"
echo "==========================================="
echo ""

# Get actual values for comparison
ingestion_rate=$(psql "$DATABASE_URL" -t -c "SELECT ROUND(100.0 * COUNT(CASE WHEN status = 'success' THEN 1 END) / NULLIF(COUNT(*), 0), 0) FROM job_logs WHERE job_type = 'ingestion' AND created_at > NOW() - INTERVAL '7 days';" 2>/dev/null | xargs)

email_rate=$(psql "$DATABASE_URL" -t -c "SELECT ROUND(100.0 * COUNT(CASE WHEN status = 'delivered' THEN 1 END) / NULLIF(COUNT(*), 0), 0) FROM email_logs WHERE created_at > NOW() - INTERVAL '7 days';" 2>/dev/null | xargs)

approval_rate=$(psql "$DATABASE_URL" -t -c "SELECT ROUND(100.0 * COUNT(CASE WHEN status = 'approved' AND edited = false THEN 1 END) / NULLIF(COUNT(*), 0), 0) FROM draft_replies WHERE created_at > NOW() - INTERVAL '7 days';" 2>/dev/null | xargs)

echo "Metric                     | Target | Actual | Status"
echo "---------------------------|--------|--------|--------"

# Ingestion success
if [ ! -z "$ingestion_rate" ] && [ "$ingestion_rate" -ge 98 ]; then
    echo "Ingestion Success Rate     | 98%    | ${ingestion_rate}%   | ✅"
elif [ ! -z "$ingestion_rate" ]; then
    echo "Ingestion Success Rate     | 98%    | ${ingestion_rate}%   | ⚠️"
else
    echo "Ingestion Success Rate     | 98%    | N/A    | ?"
fi

# Email delivery
if [ ! -z "$email_rate" ] && [ "$email_rate" -ge 97 ]; then
    echo "Email Delivery Rate        | 97%    | ${email_rate}%   | ✅"
elif [ ! -z "$email_rate" ]; then
    echo "Email Delivery Rate        | 97%    | ${email_rate}%   | ⚠️"
else
    echo "Email Delivery Rate        | 97%    | N/A    | ?"
fi

# Draft approval
if [ ! -z "$approval_rate" ] && [ "$approval_rate" -ge 80 ]; then
    echo "Draft Approval Rate        | 80%    | ${approval_rate}%   | ✅"
elif [ ! -z "$approval_rate" ]; then
    echo "Draft Approval Rate        | 80%    | ${approval_rate}%   | ⚠️"
else
    echo "Draft Approval Rate        | 80%    | N/A    | ?"
fi

echo ""
echo "==========================================="
echo "📋 ACTION ITEMS"
echo "==========================================="
echo ""

# Automatically generate action items based on metrics
action_items=()

if [ ! -z "$ingestion_rate" ] && [ "$ingestion_rate" -lt 98 ]; then
    action_items+=("• Investigate ingestion failures (see OPERATIONS.md section 2.2)")
fi

if [ ! -z "$email_rate" ] && [ "$email_rate" -lt 97 ]; then
    action_items+=("• Review email bounce reasons, validate addresses")
fi

if [ ! -z "$approval_rate" ] && [ "$approval_rate" -lt 80 ]; then
    action_items+=("• Review draft quality with restaurants, adjust tone settings")
fi

overdue_drafts=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM draft_replies WHERE status = 'pending_approval' AND created_at < NOW() - INTERVAL '48 hours';" 2>/dev/null | xargs)

if [ ! -z "$overdue_drafts" ] && [ "$overdue_drafts" -gt 0 ]; then
    action_items+=("• Follow up on $overdue_drafts overdue draft approvals")
fi

if [ ${#action_items[@]} -eq 0 ]; then
    echo "✅ No action items - all metrics on target!"
else
    printf '%s\n' "${action_items[@]}"
fi

echo ""
echo "==========================================="
echo "Report complete. Share with team!"
echo "==========================================="
echo ""
echo "To email this report:"
echo "  ./pilot-report.sh | mail -s 'Weekly Pilot Report' team@example.com"
echo ""
