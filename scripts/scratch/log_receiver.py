#!/usr/bin/env python3
"""
Simple log receiver for Render log streaming.
Receives logs via TCP and writes them to file and console.
"""

import socket
from datetime import datetime
import threading


def handle_client(client_socket, address):
    """Handle incoming log data from a client."""
    print(f"[{datetime.now().isoformat()}] Connection from {address}")

    try:
        while True:
            data = client_socket.recv(4096)
            if not data:
                break

            # Decode and process the log data
            try:
                log_str = data.decode("utf-8").strip()
                if log_str:
                    timestamp = datetime.now().isoformat()

                    # Write to file
                    with open("render_logs.txt", "a") as f:
                        f.write(f"[{timestamp}] {log_str}\n")

                    # Print to console with color
                    print(f"\033[32m[{timestamp}]\033[0m {log_str}")

            except Exception as e:
                print(f"Error processing log: {e}")

    except Exception as e:
        print(f"Client error: {e}")
    finally:
        client_socket.close()


def start_server(port=5556):
    """Start TCP server to receive logs."""
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

    server_socket.bind(("0.0.0.0", port))
    server_socket.listen(5)

    print(f"\n🚀 Log receiver listening on port {port}")
    print("📝 Logs will be saved to: render_logs.txt")
    print("\n⏳ Waiting for connections...\n")

    try:
        while True:
            client_socket, address = server_socket.accept()
            client_thread = threading.Thread(
                target=handle_client, args=(client_socket, address)
            )
            client_thread.daemon = True
            client_thread.start()
    except KeyboardInterrupt:
        print("\n\n👋 Shutting down log receiver...")
    finally:
        server_socket.close()


if __name__ == "__main__":
    start_server()
