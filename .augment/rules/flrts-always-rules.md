---
type: "always_apply"
---

# FLRTS Always Rules
**Trigger:** Always (included in EVERY message)  
**Description:** Core FLRTS principles that must never be violated

## Smart Rails Integrity
Smart Rails is the core optimization system:
- Maintain 70% token reduction target
- Preserve deterministic preprocessing for /commands and @mentions
- 100% confidence = 0 tokens (direct execution)
- Never skip confidence scoring
- Log all token savings with ⏱️ prefix

## Storage Layer Separation
Never mix storage responsibilities:
- **Supabase**: Document storage and audit logs ONLY
- **Upstash Redis**: Conversation state with 24hr TTL ONLY
- **Upstash Vector**: Semantic search with namespace "10netzero" ONLY
- **Neo4j**: Graph relationships between entities ONLY

Each layer has a specific purpose - respect the boundaries.

## Production Architecture
Production architecture rules:
- Production ALWAYS uses webhooks via main.py
- Local development uses polling via run_bot.py
- Never use polling in production (wastes resources)
- Webhook failures should gracefully degrade
- Always verify webhook after deployment: `python setup_webhook.py`

## Security & Authorization
Security requirements for every operation:
- Validate AUTHORIZED_USER_IDS before ANY user operation
- Never expose credentials in code, logs, or error messages
- All user actions must be logged to Supabase audit table
- Use prepared statements for ALL database queries
- Wrap external API calls in specific try/except blocks