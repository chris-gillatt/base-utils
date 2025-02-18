FROM rockylinux:9

# Install Utils
RUN dnf update -y -q \
    && dnf -y -q install wget iputils less unzip which telnet nmap bind-utils traceroute tcpdump iperf3 ftp python3 jq \
    && dnf -y -q clean all \
    && rpm -qa --qf "%{NAME}\n" | sort > /etc/motd

RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && echo yq >> /etc/motd

# Copy static MOTD file
COPY motd /etc/motd

# Ensure MOTD is displayed on shell start
RUN echo 'cat /etc/motd' >> /etc/bashrc

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "sleep infinity"]
