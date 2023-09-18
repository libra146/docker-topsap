# 构建说明

## 从 Dockerfile 构建

### ❗️注意：本仓库用到了 git lfs，使用前请先安装：

> 对于 Ubuntu 和 Debian，使用以下命令安装，其他系统请自行安装

```bash
sudo apt install git-lfs
```

安装好 git-lfs 后，使用以下命令构建镜像


```bash
git clone --depth=1 https://github.com/libra146/docker-topsap
cd docker-topsap
git lfs pull
docker build -t libra146/docker-topsap:0.1.0 -f Dockerfile .
```
