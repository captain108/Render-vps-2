FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    openssh-server \
    curl \
    unzip \
    wget \
    sudo \
    git \
    python3 \
    python3-pip

# Create user for SSH login
RUN useradd -m user && echo 'user:user' | chpasswd && adduser user sudo

# Set up SSH
RUN mkdir /var/run/sshd

# Install ngrok
RUN wget -q -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip && \
    unzip ngrok.zip && mv ngrok /usr/local/bin && rm ngrok.zip

# Add entrypoint
COPY entrypoint.sh /entrypoint.sh
COPY ngrok.yml /root/.config/ngrok/ngrok.yml

RUN chmod +x /entrypoint.sh

EXPOSE 22

CMD ["/entrypoint.sh"]
