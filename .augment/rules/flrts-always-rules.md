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

Always verify webhook after deployment. Run the verification script with error handling and check its exit status:

```sh
i=1
while [ $i -le 3 ]; do
	if python3 setup_webhook.py; then
		break
	else
		echo "Webhook verification failed (attempt $i)." >&2
		if [ "$i" -eq 3 ]; then
			echo "ERROR: Webhook setup failed after 3 attempts. Check logs/output above." >&2
			exit 1
		fi
		sleep 2
	fi
	i=$((i+1))
done
```

done

```

This will retry up to 3 times on transient failures, log errors, and exit nonzero if setup fails. Always check the command's output and exit code so deployments can detect and respond to webhook setup failures.

## Security & Authorization

Security requirements for every operation:

- Validate AUTHORIZED_USER_IDS before ANY user operation
- Never expose credentials in code, logs, or error messages
- All user actions must be logged to Supabase audit table
- Use prepared statements for ALL database queries
- Wrap external API calls in specific try/except blocks
```
