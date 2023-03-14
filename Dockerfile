FROM ubuntu:focal

WORKDIR /home/work

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV SERVER_ADDRESS=""
ENV USER_NAME=""
ENV PASSWORD=""

RUN ls && \
  export DEBIAN_FRONTEND=noninteractive && \
  ln -fs /usr/share/zoneinfo/Asia /etc/localtime && \
  apt-get update && apt-get -y --no-install-suggests --no-install-recommends install tzdata sudo curl dante-server && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  dpkg -i TopSAP-3.5.2.36.2-x86_64.deb && \
  rm -r TopSAP-3.5.2.36.2-x86_64.deb && \
  apt-get install -y expect && \
  rm -rf /var/lib/apt/lists/*

COPY start.sh .
COPY danted.conf /etc
COPY expect.exp .

CMD chmod +x start.sh && /home/work/start.sh
