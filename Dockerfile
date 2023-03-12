FROM ubuntu:focal

WORKDIR /home/work

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV SERVER_ADDRESS=""
ENV USER_NAME=""
ENV PASSWORD=""

RUN export DEBIAN_FRONTEND=noninteractive && \
  ln -fs /usr/share/zoneinfo/Asia /etc/localtime && \
  apt-get update && apt-get -y --no-install-suggests --no-install-recommends install tzdata sudo curl dante-server && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  curl -o /tmp/topsap.deb -k https://app.topsec.com.cn/vpn/sslvpnclient/TopSAP-3.5.2.35.2-x86_64.deb && \
  dpkg -i /tmp/topsap.deb && \
  rm -r /tmp/topsap.deb && \
  apt-get install -y expect && \
  rm -rf /var/lib/apt/lists/*

COPY start.sh .
COPY danted.conf /etc
COPY expect.exp .

CMD chmod +x start.sh && /home/work/start.sh
