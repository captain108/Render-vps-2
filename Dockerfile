FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    curl unzip wget sudo \
    && apt-get clean

# Add SSH user
RUN useradd -m user && echo "root:toss" | chpasswd && adduser user sudo

# Install ngrok
RUN mkdir -p /root/.config/ngrok
COPY root/.config/ngrok/ngrok.yml /root/.config/ngrok/ngrok.yml
RUN wget -qO ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok.zip && mv ngrok /usr/local/bin && rm ngrok.zip

# Enable SSH
RUN mkdir /var/run/sshd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Copy setup scripts
COPY root/setup.sh /setup.sh
RUN chmod +x /setup.sh

# Entry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
CMD ["/entrypoint.sh"]
