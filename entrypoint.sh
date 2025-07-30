#!/bin/bash

# Start SSH service
service ssh start

# Run setup (background ngrok)
bash /setup.sh

# Tail logs forever
tail -f /dev/null
