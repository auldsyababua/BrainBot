#!/usr/bin/env python3
"""
HTTP log receiver for Render log streaming.
Receives logs via HTTP POST and writes them to file and console.
"""

from flask import Flask, request
import json
from datetime import datetime

app = Flask(__name__)


@app.route("/logs", methods=["POST"])
def receive_logs():
    """Receive log data via HTTP POST."""
    try:
        # Get raw data or JSON
        if request.content_type == "application/json":
            log_data = request.get_json()
        else:
            log_data = request.get_data(as_text=True)

        timestamp = datetime.now().isoformat()

        # Format log entry
        if isinstance(log_data, dict):
            log_str = json.dumps(log_data)
        else:
            log_str = str(log_data)

        # Write to file
        with open("render_logs.txt", "a") as f:
            f.write(f"[{timestamp}] {log_str}\n")

        # Print to console with color
        print(f"\033[32m[{timestamp}]\033[0m {log_str}")

        return {"status": "ok"}, 200

    except Exception as e:
        print(f"Error processing log: {e}")
        return {"error": str(e)}, 500


@app.route("/health", methods=["GET"])
def health():
    """Health check endpoint."""
    return {"status": "healthy"}, 200


if __name__ == "__main__":
    print("\n🚀 HTTP Log receiver starting...")
    print("📝 Logs will be saved to: render_logs.txt")
    print("\n⏳ Waiting for logs at http://localhost:5000/logs\n")

    app.run(host="0.0.0.0", port=5000, debug=False)
