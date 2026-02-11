/**
 * SMS Review Notification Service
 * Sends review alerts via SMS and handles YES/NO approval responses.
 */

import { query } from '../db/client.js';
import { twilioClient } from './twilioClient.js';
import type { Review, ReplyDraft, Restaurant } from '../types/models.js';

const STAR_MAP: Record<number, string> = { 1: '1⭐', 2: '2⭐', 3: '3⭐', 4: '4⭐', 5: '5⭐' };

/**
 * Format the SMS notification for a new review + AI draft.
 * Keeps it under 1600 chars (Twilio sends as MMS if >160, but concatenates up to 1600).
 */
function formatReviewSms(review: Review, draft: ReplyDraft, restaurant: Restaurant): string {
  const stars = STAR_MAP[review.rating] || `${review.rating}⭐`;
  const platform = review.platform.charAt(0).toUpperCase() + review.platform.slice(1);
  const snippet = (review.text || '').slice(0, 120) + ((review.text || '').length > 120 ? '...' : '');

  // Extract just Option 1 from the draft (the generator produces two options)
  let draftSnippet = draft.draft_text;
  const opt1Match = draftSnippet.match(/Option 1[:\s]*(.+?)(?=Option 2|$)/is);
  if (opt1Match) draftSnippet = opt1Match[1].trim();
  draftSnippet = draftSnippet.slice(0, 300);

  const escalationWarning = draft.escalation_flag ? '\n⚠️ ESCALATION FLAGGED' : '';

  return [
    `🍽️ ${restaurant.name}`,
    `New ${stars} review from ${platform}:`,
    `"${snippet}"`,
    `${escalationWarning}`,
    `Suggested reply:`,
    `"${draftSnippet}"`,
    ``,
    `Reply YES to post, NO to skip, or type your own response.`,
  ].filter(Boolean).join('\n');
}

export class SmsService {
  /**
   * Send review notification SMS to restaurant owner.
   * Stores the SMS record in sms_messages table for tracking.
   */
  async sendReviewAlert(
    review: Review,
    draft: ReplyDraft,
    restaurant: Restaurant,
    ownerPhone: string,
  ): Promise<string> {
    const body = formatReviewSms(review, draft, restaurant);

    // Store pending SMS record BEFORE sending (for webhook correlation)
    const insertResult = await query<{ id: string }>(
      `INSERT INTO sms_messages (
        restaurant_id, review_id, reply_draft_id, phone_number,
        direction, body, status
      ) VALUES ($1, $2, $3, $4, 'outbound', $5, 'sending')
      RETURNING id`,
      [restaurant.id, review.id, draft.id, ownerPhone, body]
    );
    const smsId = insertResult.rows[0].id;

    try {
      const result = await twilioClient.sendSms(ownerPhone, body);

      // Update with Twilio SID
      await query(
        `UPDATE sms_messages SET status = 'sent', twilio_sid = $1 WHERE id = $2`,
        [result.sid, smsId]
      );

      console.log(`📱 Review alert sent to ${ownerPhone} for review ${review.id}`);
      return smsId;
    } catch (error) {
      await query(
        `UPDATE sms_messages SET status = 'failed', error_message = $1 WHERE id = $2`,
        [(error as Error).message, smsId]
      );
      throw error;
    }
  }

  /**
   * Handle incoming SMS response from restaurant owner.
   * Called by the webhook handler.
   */
  async handleIncomingResponse(fromPhone: string, body: string): Promise<string> {
    const trimmed = body.trim().toUpperCase();

    // Find the most recent pending outbound SMS to this phone number
    const pendingResult = await query<{
      id: string;
      review_id: string;
      reply_draft_id: string;
      restaurant_id: string;
    }>(
      `SELECT sm.id, sm.review_id, sm.reply_draft_id, sm.restaurant_id
       FROM sms_messages sm
       JOIN reply_drafts rd ON rd.id = sm.reply_draft_id
       WHERE sm.phone_number = $1
         AND sm.direction = 'outbound'
         AND rd.status = 'pending'
       ORDER BY sm.created_at DESC
       LIMIT 1`,
      [fromPhone]
    );

    if (pendingResult.rows.length === 0) {
      return 'No pending review to respond to. We\'ll send you the next one!';
    }

    const pending = pendingResult.rows[0];

    // Log inbound message
    await query(
      `INSERT INTO sms_messages (
        restaurant_id, review_id, reply_draft_id, phone_number,
        direction, body, status
      ) VALUES ($1, $2, $3, $4, 'inbound', $5, 'received')`,
      [pending.restaurant_id, pending.review_id, pending.reply_draft_id, fromPhone, body]
    );

    if (trimmed === 'YES') {
      // Approve the draft
      await query(
        `UPDATE reply_drafts SET status = 'approved', approved_at = NOW() WHERE id = $1`,
        [pending.reply_draft_id]
      );
      console.log(`✅ Draft ${pending.reply_draft_id} approved via SMS`);
      return '✅ Response approved! We\'ll post it now.';

    } else if (trimmed === 'NO') {
      // Reject the draft
      await query(
        `UPDATE reply_drafts SET status = 'rejected' WHERE id = $1`,
        [pending.reply_draft_id]
      );
      console.log(`❌ Draft ${pending.reply_draft_id} rejected via SMS`);
      return '👍 Got it, response skipped.';

    } else {
      // Custom response — replace the draft text and auto-approve
      await query(
        `UPDATE reply_drafts 
         SET draft_text = $1, status = 'approved', approved_at = NOW(),
             metadata = jsonb_set(COALESCE(metadata, '{}'), '{custom_response}', 'true')
         WHERE id = $2`,
        [body.trim(), pending.reply_draft_id]
      );
      console.log(`✏️ Custom response received for draft ${pending.reply_draft_id}`);
      return '✅ Your custom response will be posted!';
    }
  }
}

export const smsService = new SmsService();
