# 用法

**启动参数里的 `--device /dev/net/tun --cap-add NET_ADMIN` 一定要加。 因为 TopSAP 要使用它来创建虚拟网络设备。**

## 使用方法

1. 安装 Docker。

2. 在终端输入：
   `docker run -d -it --device /dev/net/tun --cap-add NET_ADMIN -p 127.0.0.1:1088:1080 --name some_name -e USER_NAME=you_name -e PASSWORD=you_password -e SERVER_ADDRESS=you_address libra146/docker-topsap`

3. 将以上命令的环境变量替换成对应的用户名密码还有服务器地址。

4. 浏览器（或其他支持的应用）可配置socks5代理，地址 127.0.0.1, 端口 1080。

5. 注意⚠️：docker 参数中的 -it 命令一定要加，因为 expect 命令需要在终端中才能正常执行，需要 docker 分配一个伪终端给 expect 用才能正常登录，否则会卡在输入密码的地方。

## 环境变量

- `USER_NAME`：用户名，TopSAP登录用户名

- `PASSWORD`：密码，ToPSAP账号登录密码

- `SERVER_ADDRESS`：服务器地址

## 如果遇到特殊字符，则可以使用文件传递环境变量的内容

1. 安装 Docker。

2. 将服务器地址，账号，密码填写到 .env 文件中对应的位置中。

3. 在终端输入：
   `docker run -d -it --device /dev/net/tun --cap-add NET_ADMIN -p 127.0.0.1:1088:1080 --name some_name --env-file .env libra146/docker-topsap`

4. 浏览器（或其他支持的应用）可配置socks5代理，地址 127.0.0.1, 端口 1080。

5. 注意⚠️：docker 参数中的 -it 命令一定要加，因为 expect 命令需要在终端中才能正常执行，需要 docker 分配一个伪终端给 expect
   用才能正常登录，否则会卡在输入密码的地方。


## 服务

### Socks5

服务启动后，会自动开启 Socks5，默认监听容器内的 1080 端口，可以使用 -p 参数将容器外部端口转发到 1080 端口，然后就可以通过容器内的 TopSAP上网啦。

## 注意❗️

TopSAP 在 docker 内运行时会获取本机的 `/sys/class/dmi/id/product_uuid` 这个文件内的信息作为本机唯一标识，docker 内的 product_uuid 标识默认取的是本机的 `/sys/class/dmi/id/product_uuid` ，如果在多个设备上登录可能会导致账号被禁用（取决于服务端设置），如果你所在的公司无 id 限制，可忽略。

```bash
root@956a2f1417dd:/home/work# cd /opt/TopSAP/
root@956a2f1417dd:/opt/TopSAP# ./sv_websrv 
Failed to create listener: cannot parse address
Starting SSL server on port 127.0.0.1:7443, cert from server.pem, key from server.key
mkdir: cannot create directory ‘/opt/sslvpn’: File exists
VPNSDK:The SDK Version is 3.4.221229.0.2

start....---------------------what
open hard disk device failed.overlay,-1
get the diskid error.
get the cpu id error.
diskId:85bc4d56-4295-422a-5510-9ea5b68cc731lUoYuAncHeNtIaNkAijWn
16_MD5:W�:�E��`G7
MD5:5795ee85a83ae345ee180305f8604737
featureCode:5795ee85a83ae345ee180305f8604737
```

目前暂不清楚 Mac 版和 Linux 版获取了什么信息当作了本机唯一标识。

可以确定的是，docker 中因为其他信息获取失败了，所以会获取  `/sys/class/dmi/id/product_uuid` 这里的信息当作唯一标识，如果需要在多个地方运行 docker 容器，需要使用下面的方法来设置标识的值码，使其在多个地方都相同。

```bash
user:~$ sudo cat /sys/class/dmi/id/product_uuid 
85bc4d56-4295-422a-5510-9ea5b68cc731
user:~$ docker run --rm -it ubuntu:22.10 bash
root@3eedbe1d0994:/# cat /sys/class/dmi/id/product_uuid 
85bc4d56-4295-422a-5510-9ea5b68cc731
root@3eedbe1d0994:/# 
exit
user:~$ echo 111 > uuid
user:~$ cat uuid
111
user:~$ docker run --rm -it -v ./uuid:/sys/class/dmi/id/product_uuid ubuntu:22.10 bash
root@f0a197866f1c:/# cat /sys/class/dmi/id/product_uuid 
111
root@f0a197866f1c:/# 
```

在 docker 运行时，使用 `-v` 命令将本地的 uuid 映射到容器中即可修改容器内的 product_uuid。
