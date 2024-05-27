# docker-topsap

[![Docker-publish](https://github.com/libra146/docker-topsap/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/libra146/docker-topsap/actions/workflows/docker-publish.yml)
![GitHub issues](https://img.shields.io/github/issues/libra146/docker-topsap)
![GitHub repo size](https://img.shields.io/github/repo-size/libra146/docker-topsap)
![Docker Pulls](https://img.shields.io/docker/pulls/libra146/docker-topsap)
[![GitHub](https://img.shields.io/github/license/libra146/docker-topsap)](https://github.com/libra146/docker-topsap/blob/main/LICENSE)

使天融信开发的 TopSAP 运行在 docker 或 podman 中，并提供 socks5 代理服务

**本项目基于 天融信 官方“Linux”版的 deb 包制作。这些 deb 包的版权归 天融信 官方所有，请不要滥用本项目。本项目不是天融信官方项目。
**

望批评、指正。欢迎提交 issue、PR，包括但不仅限于 bug、各种疑问、代码和文档的改进。

详细用法见于 [doc/usage.md](https://github.com/libra146/docker-topsap/blob/main/doc/usage.md)
，常见问题见于 [doc/faq.md](https://github.com/libra146/docker-topsap/blob/main/doc/faq.md)
，自行构建可参照构建说明 [doc/build.md](https://github.com/libra146/docker-topsap/blob/main/doc/build.md)。

## 特别声明

本仓库中涉及的任何代码，仅用于测试和学习研究，禁止用于商业用途，不能保证其合法性，准确性，完整性和有效性，请根据情况自行判断。

任何用户直接或间接使用的任何代码，无论该等使用是否符合其所在国家或地区，无论该等使用或传播发生的国家或地区的法律，代码仓库的所有者及任何其他贡献者均不对该等行为产生的任何后果（包括但不限于隐私泄露）负责。

如果任何单位或个人认为该项目的代码可能涉嫌侵犯其权利，则应及时通知并提供身份证明，所有权证明，我们将在收到认证文件后删除相关代码。


## 特别感谢

从 [docker-easyconnect](https://github.com/Hagb/docker-easyconnect/) 这个项目获得灵感，并且也参考了部分 docker 构建代码和 iptables 相关代码，特此感谢！
