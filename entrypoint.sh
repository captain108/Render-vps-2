#!/bin/bash

# Start SSH
service ssh start

# Start ngrok
ngrok tcp 22 &

# Keep container alive
tail -f /dev/null
