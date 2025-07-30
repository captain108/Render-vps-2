#!/bin/bash

# Start ngrok tunnel for port 22
ngrok tcp 22 > /dev/null &

# Wait for tunnel to come up
sleep 5

# Extract tunnel info
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o 'tcp://[^"]*')
HOST=$(echo "$NGROK_URL" | sed -E 's/tcp:\/\/([^:]+):([0-9]+)/\1/')
PORT=$(echo "$NGROK_URL" | sed -E 's/tcp:\/\/([^:]+):([0-9]+)/\2/')

# Show connection info
echo "======================================"
echo "🟢 SSH Tunnel Active"
echo "📬 Connect using:"
echo "ssh user@$HOST -p $PORT"
echo "======================================"
