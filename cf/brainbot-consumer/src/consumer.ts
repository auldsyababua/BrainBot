async function hmacHex(secret: string, data: string): Promise<string> {
  const enc = new TextEncoder();
  const key = await crypto.subtle.importKey(
    "raw",
    enc.encode(secret),
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"]
  );
  const sig = await crypto.subtle.sign("HMAC", key, enc.encode(data));
  return Array.from(new Uint8Array(sig))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

export interface Env {
  PROCESS_URL: string;
  CF_PROXY_SECRET: string;
  BRAINBOT_KV: KVNamespace;
}

export default {
  async queue(batch: MessageBatch<any>, env: Env, ctx: ExecutionContext) {
    for (const msg of batch.messages) {
      const payload = JSON.stringify(msg.body);
      const ts = Math.floor(Date.now() / 1000).toString();
      const sig = await hmacHex(env.CF_PROXY_SECRET, `${ts}.${payload}`);
      try {
        const res = await fetch(env.PROCESS_URL, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-Request-Timestamp": ts,
            "X-BrainBot-Signature": `v1=${sig}`,
          },
          body: payload,
        });
        if (res.ok) {
          msg.ack();
        } else {
          msg.retry();
        }
      } catch (err) {
        msg.retry();
      }
    }
  },
} satisfies ExportedHandler<Env>;


