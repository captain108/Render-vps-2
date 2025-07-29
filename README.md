# Render SSH Server with Ngrok

This project creates a Docker container on Render.com with:

- OpenSSH server
- User: `user` / Password: `user`
- Exposed over ngrok TCP tunnel
- Auto-starts on deploy

## 🔐 Security

- Uses password auth (`user:user`)
- You can switch to SSH key login if needed
- Uses your personal ngrok token for stable connection

## 🚀 Usage

1. Edit Dockerfile and insert your `NGROK_AUTHTOKEN`
2. Push to GitHub
3. Deploy as Docker Web Service on Render
4. Check logs: your `ssh user@host -p port` info will appear
