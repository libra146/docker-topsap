# 常见问题

## /dev/net/tun doesn't exist. Please create it first.

请检查在运行 docker 时是否添加了以下参数：

```bash
`--device /dev/net/tun --cap-add NET_ADMIN`
```


## 其他问题

请提交 [issue](https://github.com/libra146/docker-topsap/issues) 反馈。