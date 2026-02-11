/**
 * Restaurant SaaS Backend - Main Entry Point
 * 
 * This is a simple HTTP server for health checks and manual job triggers.
 * The actual jobs run on scheduled cron tasks.
 */

import http from 'http';
import dotenv from 'dotenv';
import pool from './db/client.js';
import { ingestionJob } from './jobs/ingestion.js';
import { newsletterJob } from './jobs/newsletter.js';
import { reviewMonitor } from './jobs/reviewMonitor.js';
import { responsePoster } from './services/responsePoster.js';
import { handleSmsWebhook } from './sms/webhookHandler.js';

dotenv.config();

const PORT = process.env.PORT || 3000;

const server = http.createServer(async (req, res) => {
  const url = new URL(req.url || '/', `http://${req.headers.host}`);

  // Health check
  if (url.pathname === '/health') {
    try {
      await pool.query('SELECT 1');
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        status: 'healthy', 
        timestamp: new Date().toISOString(),
        database: 'connected'
      }));
    } catch (error) {
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        status: 'unhealthy', 
        error: 'Database connection failed' 
      }));
    }
    return;
  }

  // Twilio SMS webhook (incoming messages)
  if (url.pathname === '/sms/webhook' && req.method === 'POST') {
    await handleSmsWebhook(req, res);
    return;
  }

  // Manual trigger: review monitor poll
  if (url.pathname === '/jobs/reviews/poll' && req.method === 'POST') {
    res.writeHead(202, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'accepted', message: 'Review poll started' }));
    reviewMonitor.runOnce().catch(console.error);
    return;
  }

  // Manual trigger: post approved responses
  if (url.pathname === '/jobs/responses/post' && req.method === 'POST') {
    res.writeHead(202, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'accepted', message: 'Response posting started' }));
    responsePoster.processApprovedDrafts().catch(console.error);
    return;
  }

  // Manual trigger for ingestion job (for testing)
  if (url.pathname === '/jobs/ingestion/run' && req.method === 'POST') {
    try {
      res.writeHead(202, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        status: 'accepted', 
        message: 'Ingestion job started' 
      }));
      
      // Run job asynchronously
      ingestionJob.run().catch(console.error);
    } catch (error: any) {
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: error.message }));
    }
    return;
  }

  // Manual trigger for newsletter job (for testing)
  if (url.pathname === '/jobs/newsletter/run' && req.method === 'POST') {
    try {
      res.writeHead(202, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        status: 'accepted', 
        message: 'Newsletter job started' 
      }));
      
      // Run job asynchronously
      newsletterJob.run().catch(console.error);
    } catch (error: any) {
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: error.message }));
    }
    return;
  }

  // 404
  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Not found' }));
});

server.listen(PORT, () => {
  console.log('🚀 Restaurant SaaS Backend Started');
  console.log(`   Port: ${PORT}`);
  console.log(`   Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`\n📋 Available endpoints:`);
  console.log(`   GET  /health                  - Health check`);
  console.log(`   POST /sms/webhook             - Twilio incoming SMS webhook`);
  console.log(`   POST /jobs/reviews/poll       - Trigger review poll`);
  console.log(`   POST /jobs/responses/post     - Post approved responses`);
  console.log(`   POST /jobs/ingestion/run      - Trigger ingestion job`);
  console.log(`   POST /jobs/newsletter/run     - Trigger newsletter job`);
  console.log(`\n💡 Scheduled jobs should run via cron (see README.md)`);

  // Start review monitor (polls every 5 min)
  if (process.env.ENABLE_REVIEW_MONITOR !== 'false') {
    reviewMonitor.start().catch(console.error);
  }

  // Start response poster loop (checks every minute)
  if (process.env.ENABLE_RESPONSE_POSTER !== 'false') {
    setInterval(() => {
      responsePoster.processApprovedDrafts().catch(console.error);
    }, 60_000);
  }
});

// Graceful shutdown
process.on('SIGTERM', async () => {
  console.log('SIGTERM received, shutting down gracefully...');
  server.close(async () => {
    await pool.end();
    process.exit(0);
  });
});
