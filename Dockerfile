FROM rockylinux:9

# Install Utils
RUN dnf update -y -q \
    && dnf -y -q install sudo wget iputils less zip unzip which telnet nmap bind-utils traceroute tcpdump iperf3 ftp python3 jq \
    && dnf -y -q clean all \
    && rpm -qa --qf "%{NAME}\n" | sort > /etc/motd

RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq

# Copy static MOTD file
COPY --chmod=644 motd /etc/motd

# Modify the default .bashrc template to show MOTD for new users
RUN echo 'cat /etc/motd' >> /etc/skel/.bashrc

# Create a sandbox user with full permissions
RUN useradd -m -G wheel sandbox