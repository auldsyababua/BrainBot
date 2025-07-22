#!/usr/bin/env python3
"""
Dead simple syslog server for Render logs.
No ngrok, no credit cards, no BS.
"""

import socketserver
import logging
from datetime import datetime

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format="%(message)s",
    handlers=[logging.FileHandler("render_bot_logs.log"), logging.StreamHandler()],
)


class SyslogUDPHandler(socketserver.BaseRequestHandler):
    def handle(self):
        data = bytes.decode(self.request[0].strip())
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] {data}"
        logging.info(log_entry)


if __name__ == "__main__":
    HOST, PORT = "0.0.0.0", 514

    print("\n🚀 Simple Syslog Server")
    print("=" * 40)
    print(f"Listening on port {PORT}")
    print("Logs saved to: render_bot_logs.log")
    print("\nFor Render, use:")
    print(f"Endpoint: YOUR_PUBLIC_IP:{PORT}")
    print("Token: (leave empty)")
    print("\nTo find your public IP: curl ifconfig.me")
    print("=" * 40)
    print("\nWaiting for logs...\n")

    try:
        server = socketserver.UDPServer((HOST, PORT), SyslogUDPHandler)
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n👋 Shutting down...")
