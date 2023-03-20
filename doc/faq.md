# 常见问题

## /dev/net/tun doesn't exist. Please create it first.

请检查在运行 docker 时是否添加了以下参数：

```bash
`--device /dev/net/tun --cap-add NET_ADMIN`
```

## Device tun0 not found.
目前测试不会每次都复现，可以重试一下，应该就可以了，如果不可以请反馈。

## 其他问题

请提交 [issue](https://github.com/libra146/docker-topsap/issues) 反馈。