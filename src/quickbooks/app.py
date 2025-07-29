"""QuickBooks Integration API Server"""

import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from src.quickbooks.webhook_server import app as webhook_app

# Create main app
app = FastAPI(
    title="10NetZero QuickBooks Integration",
    description="Real-time sync between QuickBooks and Supabase",
    version="1.0.0",
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://10nz.tools", "https://10netzero.com"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount the webhook app
app.mount("/", webhook_app)


# Health check endpoint
@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "service": "quickbooks-integration",
        "environment": os.getenv("QB_ENVIRONMENT", "production"),
    }


if __name__ == "__main__":
    import uvicorn

    port = int(os.getenv("PORT", 8000))
    uvicorn.run("app:app", host="0.0.0.0", port=port, reload=True)
