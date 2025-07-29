#!/bin/bash

# Start web server in background
python3 /app/keep_alive.py &

# Start SSH
service ssh start

# Start ngrok tunnel
ngrok config add-authtoken "$NGROK_AUTHTOKEN"
ngrok tcp 22 > /tmp/ngrok.log &

# Wait for ngrok to start
sleep 5

# Display SSH info
SSH_URL=$(grep -o 'tcp://[0-9a-zA-Z.:]*' /tmp/ngrok.log | head -n 1)
echo "======================================="
echo "🟢 SSH Tunnel Active"
echo "📬 Connect using:"
echo "ssh user@${SSH_URL:6}"
echo "======================================="

# Keep container alive
tail -f /dev/null
