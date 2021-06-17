# ubuntu利用netplay配置

```bash
# 在应用改变之前，让我们测试一下配置。
sudo netplan try
sudo netplan --debug apply
sudo netplan apply
```

```yaml
# This is the network config written by 'subiquity'
network:
  ethernets:
    eno1:
      dhcp4: true
    eno2:
      dhcp4: no
      addresses: [192.168.1.141/24]
      optional: true
      gateway4: 192.168.1.1
      nameservers:
              addresses: [183.221.253.100,8.8.8.8]
    eno3:
      dhcp4: true
    eno4:
      dhcp4: true
  version: 2
~
```

其它都好理解，但是addresses后面的24是什么

addresses along with the subnet prefix length (e.g. /24). 

地址以及子网前缀长度

这个代表掩码，24代表255.255.255.0（二进制:11111111.11111111.11111111.0)24个是1

附一个百度查的列表

![子网掩码](./images/netmask.jpeg)
