## vim 支持ansible格式


`.vimrc`配置, 所有在**playbooks**目录下面的`yml`文件才使用`ansible`模板:
```vim
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
```
