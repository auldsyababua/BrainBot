export interface Env {
  TELEGRAM_WEBHOOK_SECRET: string;
  CF_PROXY_SECRET: string;
  UPDATES: Queue<unknown>;
  BRAINBOT_KV: KVNamespace;
  BRAINBOT_MEDIA: R2Bucket;
}

export default {
  async fetch(request, env, _ctx) {
    if (request.method !== "POST") return new Response("ok");

    const secret = request.headers.get("X-Telegram-Bot-Api-Secret-Token");
    if (env.TELEGRAM_WEBHOOK_SECRET && secret !== env.TELEGRAM_WEBHOOK_SECRET) {
      return new Response("unauthorized", { status: 401 });
    }

    const body = await request.text();
    const meta = {
      ip: request.headers.get("CF-Connecting-IP"),
      ua: request.headers.get("User-Agent"),
      ts: Date.now(),
    };
    await env.UPDATES.send({ body, meta });
    return new Response("ok");
  },
} satisfies ExportedHandler<Env>;


