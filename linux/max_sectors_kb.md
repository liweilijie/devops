# max_sectors_kb 值修改

**In addition, change the default maximum I/O size of the Linux kernel from 1,280 KB to
512 KB using ** `udev`. Run the following command to create a file named `71-block-max-sectors.rules` under '/etc/udev/rules.d':

```test
ACTION=="add|change", SUBSYSTEM=="block", RUN+="/bin/sh -c '/bin/echo 512 > /sys%p/queue/max_sectors_kb'"
```

A reboot is required to activate this setting.

![西部数据io error](./images/wd_ioerror.png)


解决方案：

**sudo vi /etc/udev/rules.d/71-block-max-sectors.rules** 写入内容：

```text
ACTION=="add", SUBSYSTEM=="block", RUN+="/bin/sh -c '/bin/echo 128 > /sys%p/queue/max_sectors_kb'"
```

然后重启，重启后再查看：

```bash
cat /sys/block/md0/queue/max_sectors_kb
128
cat /sys/block/nvme0n1/queue/max_sectors_kb
128
```

参考链接：

- [参考](https://longwhiteclouds.com/2016/03/06/default-io-size-change-in-linux-kernel/)
- [linux kernel settings](https://infohub.delltechnologies.com/l/validation-guide-sap-hana-on-dell-emc-poweredge-for-vmware-vsan-hyperconverged-infrastructure-1/linux-kernel-settings-2)
