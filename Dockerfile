FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV NGROK_AUTHTOKEN=your-ngrok-token-here

RUN apt-get update && apt-get install -y \
    openssh-server curl unzip gnupg2 python3-pip && \
    mkdir /var/run/sshd && \
    useradd -m user && echo 'user:user' | chpasswd

COPY requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

# Install ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt update && apt install -y ngrok

COPY entrypoint.sh /entrypoint.sh
COPY keep_alive.py /app/keep_alive.py
RUN chmod +x /entrypoint.sh

EXPOSE 22 10000
CMD ["/entrypoint.sh"]
