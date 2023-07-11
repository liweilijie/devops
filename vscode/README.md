# vscode

vscode 常用配置

**CMD+B**: 显示隐藏侧边栏
**ctrl+`** : 显示|关闭终端
**ctrl+shift+`**: 新建终端

## settings

在这里如果`zsh`用什么字体的话，这里最好设置成一样的字体才不会显示乱码。

```json
{
    "terminal.integrated.fontFamily": "SauceCodePro Nerd Font"
}
```

## 冲突

如果有某个快捷键冲突了,比如 `cmd+b` 在 markdown 模式下面就会冲突,这时候打开快捷键配置面板`cmd+k cmd+s`, 搜索 cmd+b 找到之后,可以 replace 或者右击删除也可以.
