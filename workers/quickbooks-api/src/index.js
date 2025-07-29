/**
 * QuickBooks Webhook Handler for Cloudflare Workers
 */

import { createClient } from '@supabase/supabase-js';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, intuit-signature',
};

// Verify webhook signature
async function verifyWebhookSignature(payload, signature, webhookToken) {
  const encoder = new TextEncoder();
  const key = await crypto.subtle.importKey(
    'raw',
    encoder.encode(webhookToken),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign', 'verify']
  );
  
  const expectedSignature = await crypto.subtle.sign(
    'HMAC',
    key,
    encoder.encode(payload)
  );
  
  const expectedHex = Array.from(new Uint8Array(expectedSignature))
    .map(b => b.toString(16).padStart(2, '0'))
    .join('');
  
  return expectedHex === signature;
}

// Process webhook event
async function processWebhookEvent(env, realmId, entity) {
  const supabase = createClient(env.SUPABASE_URL, env.SUPABASE_SERVICE_KEY);
  
  // Log the event
  const { data: eventData, error: eventError } = await supabase
    .from('quickbooks_webhook_events')
    .insert({
      realm_id: realmId,
      entity_name: entity.name,
      entity_id: entity.id,
      operation: entity.operation,
      event_time: entity.lastUpdated,
      processing_status: 'pending'
    })
    .select()
    .single();
  
  if (eventError) {
    console.error('Error logging webhook event:', eventError);
    return;
  }
  
  // Queue for async processing
  // For now, just mark as completed
  await supabase
    .from('quickbooks_webhook_events')
    .update({ 
      processing_status: 'queued',
      processed_at: new Date().toISOString()
    })
    .eq('id', eventData.id);
}

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // Handle CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders });
    }
    
    // Remove /api/quickbooks prefix if present
    let pathname = url.pathname;
    if (pathname.startsWith('/api/quickbooks')) {
      pathname = pathname.replace('/api/quickbooks', '');
    }
    
    // Health check
    if (pathname === '/health' || pathname === '/') {
      return new Response(JSON.stringify({
        status: 'healthy',
        service: 'quickbooks-webhook-worker',
        environment: env.QB_ENVIRONMENT || 'production'
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }
    
    // OAuth redirect handler
    if (pathname === '/callback') {
      const code = url.searchParams.get('code');
      const state = url.searchParams.get('state');
      const realmId = url.searchParams.get('realmId');
      
      if (!code || !realmId) {
        return new Response('Missing required parameters', { status: 400 });
      }
      
      // For production, you'd exchange the code for tokens here
      // For now, redirect to a success page
      return Response.redirect(`https://10nz.tools/quickbooks/success?realmId=${realmId}`, 302);
    }
    
    // Webhook handler
    if ((pathname === '/webhooks/quickbooks' || pathname === '/webhooks') && request.method === 'POST') {
      try {
        const signature = request.headers.get('intuit-signature');
        const payload = await request.text();
        
        // Verify signature if provided
        if (signature && env.QB_WEBHOOK_TOKEN) {
          const isValid = await verifyWebhookSignature(payload, signature, env.QB_WEBHOOK_TOKEN);
          if (!isValid) {
            return new Response('Invalid signature', { status: 401 });
          }
        }
        
        // Parse webhook data
        const webhookData = JSON.parse(payload);
        
        // Process events asynchronously
        const promises = [];
        for (const notification of webhookData.eventNotifications || []) {
          const realmId = notification.realmId;
          const entities = notification.dataChangeEvent?.entities || [];
          
          for (const entity of entities) {
            promises.push(processWebhookEvent(env, realmId, entity));
          }
        }
        
        // Wait for all events to be logged
        ctx.waitUntil(Promise.all(promises));
        
        return new Response(JSON.stringify({ status: 'success' }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
        
      } catch (error) {
        console.error('Webhook error:', error);
        return new Response(JSON.stringify({ error: error.message }), {
          status: 500,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }
    }
    
    // OAuth initiation
    if (pathname === '/auth/quickbooks' || pathname === '/auth') {
      const companyId = url.searchParams.get('company_id');
      if (!companyId) {
        return new Response('Missing company_id', { status: 400 });
      }
      
      const state = `${companyId}:${crypto.randomUUID()}`;
      const authUrl = `https://appcenter.intuit.com/connect/oauth2/authorize?` +
        `client_id=${env.QB_CLIENT_ID}&` +
        `response_type=code&` +
        `scope=com.intuit.quickbooks.accounting openid profile email&` +
        `redirect_uri=https://10nz.tools/api/quickbooks/callback&` +
        `state=${state}`;
      
      return new Response(JSON.stringify({ auth_url: authUrl }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }
    
    return new Response('Not found', { status: 404 });
  },
};