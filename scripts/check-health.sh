#!/bin/bash
# Restaurant SaaS - Daily Health Check
# Run this every morning to catch issues early

set -e

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "========================================"
echo "🍽️  RESTAURANT SAAS HEALTH CHECK"
echo "========================================"
echo "Time: $(date)"
echo ""

# Load database URL from .env
if [ -f ~/.openclaw/workspace/.env ]; then
    source ~/.openclaw/workspace/.env
elif [ -f ~/restaurant-saas/.env ]; then
    source ~/restaurant-saas/.env
elif [ -f ~/restaurant-saas/backend/.env ]; then
    source ~/restaurant-saas/backend/.env
else
    echo "❌ Error: .env file not found"
    echo "Searched in:"
    echo "  - ~/.openclaw/workspace/.env"
    echo "  - ~/restaurant-saas/.env"
    echo "  - ~/restaurant-saas/backend/.env"
    exit 1
fi

if [ -z "$DATABASE_URL" ]; then
    echo "❌ Error: DATABASE_URL not set in .env"
    exit 1
fi

# Check database connection
echo "📡 Testing database connection..."
if psql "$DATABASE_URL" -c "SELECT 1;" > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Database connected${NC}"
else
    echo -e "${RED}❌ Database connection failed${NC}"
    exit 1
fi

echo ""
echo "=========================================="
echo "📊 DAILY OVERVIEW"
echo "=========================================="

# Note: These queries assume the views exist. If not, they'll fail gracefully.
# To create views, run the SQL in OPERATIONS.md section 3.1

if psql "$DATABASE_URL" -c "SELECT * FROM v_daily_health;" -x 2>/dev/null; then
    echo ""
else
    echo "ℹ️  View 'v_daily_health' not found. Run setup SQL from OPERATIONS.md section 3.1"
    echo ""
    
    # Fallback: Basic queries
    echo "Active Restaurants:"
    psql "$DATABASE_URL" -c "SELECT COUNT(*) as count FROM restaurants WHERE status = 'active';" -t
    
    echo "Reviews (24h):"
    psql "$DATABASE_URL" -c "SELECT COUNT(*) as count FROM reviews WHERE created_at > NOW() - INTERVAL '24 hours';" -t 2>/dev/null || echo "0"
    
    echo "Emails Sent (24h):"
    psql "$DATABASE_URL" -c "SELECT COUNT(*) as count FROM email_logs WHERE created_at > NOW() - INTERVAL '24 hours';" -t 2>/dev/null || echo "0"
fi

echo ""
echo "=========================================="
echo "🏪 RESTAURANT STATUS"
echo "=========================================="

if psql "$DATABASE_URL" -c "SELECT 
  name, 
  CASE 
    WHEN last_ingestion_at > NOW() - INTERVAL '24 hours' THEN '✅ Recent'
    WHEN last_ingestion_at > NOW() - INTERVAL '48 hours' THEN '⚠️  1d ago'
    WHEN last_ingestion_at IS NULL THEN '❌ Never'
    ELSE '❌ Stale'
  END as ingestion_status,
  last_ingestion_at::timestamp(0) as last_ingestion
FROM restaurants 
WHERE status = 'active'
ORDER BY last_ingestion_at ASC NULLS FIRST
LIMIT 20;" 2>/dev/null; then
    echo ""
else
    echo "ℹ️  Restaurant table query failed - check if schema exists"
    echo ""
fi

echo "=========================================="
echo "📧 EMAIL HEALTH (7 days)"
echo "=========================================="

if psql "$DATABASE_URL" -c "SELECT * FROM v_email_health;" 2>/dev/null; then
    echo ""
else
    echo "ℹ️  View 'v_email_health' not found"
    echo ""
    
    # Fallback query
    psql "$DATABASE_URL" -c "
    SELECT 
      COUNT(*) as total_sent,
      COUNT(CASE WHEN status = 'delivered' THEN 1 END) as delivered,
      COUNT(CASE WHEN status = 'bounced' THEN 1 END) as bounced,
      COUNT(CASE WHEN status = 'failed' THEN 1 END) as failed,
      ROUND(100.0 * COUNT(CASE WHEN status = 'delivered' THEN 1 END) / NULLIF(COUNT(*), 0), 2) as delivery_rate
    FROM email_logs
    WHERE created_at > NOW() - INTERVAL '7 days';" 2>/dev/null || echo "No email data"
    
    echo ""
fi

echo "=========================================="
echo "🔴 RECENT ERRORS (24h)"
echo "=========================================="

error_count=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM job_logs WHERE status = 'failed' AND created_at > NOW() - INTERVAL '24 hours';" 2>/dev/null || echo "0")

if [ "$error_count" -gt 0 ]; then
    echo -e "${RED}Found $error_count errors:${NC}"
    echo ""
    psql "$DATABASE_URL" -c "
    SELECT 
      created_at::timestamp(0) as time,
      job_type,
      error_type,
      LEFT(error_details, 50) as error_summary
    FROM job_logs 
    WHERE status = 'failed' AND created_at > NOW() - INTERVAL '24 hours'
    ORDER BY created_at DESC 
    LIMIT 10;" 2>/dev/null
else
    echo -e "${GREEN}✅ No errors in the last 24 hours${NC}"
fi

echo ""
echo "=========================================="
echo "⏰ PENDING ITEMS"
echo "=========================================="

pending_count=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM draft_replies WHERE status = 'pending_approval';" 2>/dev/null || echo "0")

if [ "$pending_count" -gt 0 ]; then
    echo "Draft replies pending approval: $pending_count"
    
    overdue_count=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM draft_replies WHERE status = 'pending_approval' AND created_at < NOW() - INTERVAL '48 hours';" 2>/dev/null || echo "0")
    
    if [ "$overdue_count" -gt 0 ]; then
        echo -e "${YELLOW}⚠️  $overdue_count drafts are >48h old (check with restaurants)${NC}"
    fi
else
    echo -e "${GREEN}✅ No pending draft replies${NC}"
fi

echo ""
echo "=========================================="
echo "📝 SUMMARY"
echo "=========================================="

# Overall health assessment
echo ""
if [ "$error_count" -eq 0 ] && [ "$pending_count" -lt 10 ]; then
    echo -e "${GREEN}🎉 SYSTEM HEALTHY - All systems operational${NC}"
elif [ "$error_count" -gt 5 ]; then
    echo -e "${RED}🚨 ATTENTION REQUIRED - Multiple errors detected${NC}"
    echo "   → Review error log above"
    echo "   → Check OPERATIONS.md section 2.2 for recovery steps"
elif [ "$error_count" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  MINOR ISSUES - Some errors detected${NC}"
    echo "   → Review and resolve during business hours"
else
    echo -e "${GREEN}✅ ALL CLEAR - Minor items to monitor${NC}"
fi

echo ""
echo "Next steps:"
echo "  • Review any errors above"
echo "  • Check pending drafts if >10"
echo "  • Monitor email delivery rates"
echo "  • View full dashboard: ~/restaurant-saas/dashboard.html"
echo ""
echo "For issues, consult: ~/restaurant-saas/OPERATIONS.md"
echo "========================================"
echo "Health check complete at $(date)"
echo "========================================"
