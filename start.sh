#!/bin/bash

# 判断tun0是否存在的
if [ -e /dev/net/tun ]; then
  :
else
  echo "/dev/net/tun doesn't exist. Please create it first." >&2
  exit 1
fi

# 定义一个处理函数，用于在接收到 INT 信号时退出脚本
function cleanup {
  echo "Exiting script..."
  exit 0
}

# 捕获 INT 信号，并调用 cleanup 函数
trap cleanup INT

sed -i "s/{{server_address}}/$SERVER_ADDRESS/g" expect.exp
sed -i "s/{{user_name}}/$USER_NAME/g" expect.exp
sed -i "s/{{password}}/$PASSWORD/g" expect.exp

cd /opt/TopSAP && ./sv_websrv >/home/work/sv_websrv.log 2>&1 &

sleep 1

expect -f expect.exp

for i in {1..3}; do
  if [ -e "/sys/class/net/tun0" ]; then
    # 如果设备存在，跳出循环
    danted -f /etc/danted.conf &
    break
  else
    # 如果设备不存在，等待三秒后进行下一次判断
    sleep 3
  fi
done

# 循环结束后判断设备是否存在
if [ ! -e "/sys/class/net/tun0" ]; then
  echo "Device tun0 not found."
  exit 1
fi

wait
