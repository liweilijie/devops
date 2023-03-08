# mac 常用

**截图**:

- Cmd+Shift+3: 全屏截图，保存到桌面。
- Cmd+Shift+4: 区域截图。
- Shift + Cmd + 4 了之后按空格可以进行窗口截屏。

还有一个高级功能，如果你希望截图之后不直接保存在桌面，而是保存在系统「剪贴板」中（这样你可以用 Cmmand + V 直接将截图粘贴到 Page 或其他文档中）可以在截图时同时按下 Control ，即：截全屏并保存到剪贴板：
- Shift + Cmmand + Control + 3 截取选择区域并保存到剪贴板：
- Shift + Cmmand + Control + 4 截取窗口并保存到剪贴板：
- Shift + Cmmand + Control + 4 + 空格


## ssh

在 `mac` 上面设置 **ssh** 的连接，有时候设置了会失效可能就是配置文件里面掉了，这时候可以是由于更新了系统之类的搞掉的，这时候再修改一下配置文件即可。

**sudo vi /etc/ssh/ssh_config**

```yaml
Host *
    SendEnv LANG LC_*
    IPQoS=throughput
    # 断开时重试连接的次数
    ServerAliveCountMax 5
    # 每隔5秒自动发送一个空的请求以保持连接
    ServerAliveInterval 5
```
