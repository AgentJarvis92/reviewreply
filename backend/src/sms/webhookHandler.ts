/**
 * Twilio SMS Webhook Handler
 * Receives incoming SMS via Twilio webhook POST and processes approval responses.
 */

import type { IncomingMessage, ServerResponse } from 'http';
import { smsService } from './smsService.js';

/**
 * Parse URL-encoded form body (Twilio sends application/x-www-form-urlencoded)
 */
function parseFormBody(req: IncomingMessage): Promise<Record<string, string>> {
  return new Promise((resolve, reject) => {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      const params: Record<string, string> = {};
      for (const pair of body.split('&')) {
        const [key, val] = pair.split('=');
        if (key) params[decodeURIComponent(key)] = decodeURIComponent(val || '');
      }
      resolve(params);
    });
    req.on('error', reject);
  });
}

/**
 * Respond with TwiML (Twilio Markup Language) — sends an SMS reply.
 */
function twimlResponse(res: ServerResponse, message: string): void {
  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Message>${escapeXml(message)}</Message>
</Response>`;
  res.writeHead(200, { 'Content-Type': 'text/xml' });
  res.end(xml);
}

function escapeXml(s: string): string {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

/**
 * Handle POST /sms/webhook — Twilio incoming SMS webhook
 */
export async function handleSmsWebhook(req: IncomingMessage, res: ServerResponse): Promise<void> {
  try {
    const params = await parseFormBody(req);
    const from = params.From || '';
    const body = params.Body || '';

    console.log(`📨 Incoming SMS from ${from}: "${body.slice(0, 50)}..."`);

    if (!from || !body) {
      twimlResponse(res, 'Invalid message received.');
      return;
    }

    const reply = await smsService.handleIncomingResponse(from, body);
    twimlResponse(res, reply);
  } catch (error) {
    console.error('❌ SMS webhook error:', error);
    twimlResponse(res, 'Something went wrong. Please try again.');
  }
}
