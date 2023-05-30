FROM debian:buster-slim

WORKDIR /home/work

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV SERVER_ADDRESS=""
ENV USER_NAME=""
ENV PASSWORD=""

COPY TopSAP-3.5.2.36.2-x86_64.deb .

RUN export DEBIAN_FRONTEND=noninteractive && \
  ln -fs /usr/share/zoneinfo/Asia /etc/localtime && \
  # if [ "${BUILD_ENV}" = "local" ]; then sed -i s/deb.debian.org/mirrors.aliyun.com/ /etc/apt/sources.list; fi &&\
  apt-get update && apt-get -y --no-install-suggests --no-install-recommends install tzdata sudo curl dante-server iproute2 ca-certificates iptables psmisc cron && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  # 解决TopSap检测到Debian系统无法安装的问题，可以看这篇文章：https://blog.d77.xyz/archives/649aab5b.html
  echo Ubuntu >> /etc/issue && \
   # 根据架构安装对应的 TopSAP
  if [ "$(uname -m)" = "x86_64" ]; then dpkg -i TopSAP-3.5.2.36.2-x86_64.deb; else dpkg -i TopSAP-3.5.2.36.2-aarch64.deb; fi && \
  rm -r TopSAP-3.5.2.36.2-x86_64.deb TopSAP-3.5.2.36.2-aarch64.deb && \
  apt-get install -y expect && \
  rm -rf /var/lib/apt/lists/*

COPY start.sh .
COPY danted.conf /etc
COPY expect.exp .

CMD chmod +x start.sh && /home/work/start.sh
