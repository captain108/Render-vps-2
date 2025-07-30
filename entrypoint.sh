#!/bin/bash
# Start SSH normally
/etc/init.d/ssh start

# Dummy listener to keep a port open (e.g., port 8080)
socat TCP-LISTEN:8080,fork EXEC:/bin/cat &

# Keep container running
tail -f /dev/null
