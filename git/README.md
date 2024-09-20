# git

git 多个远程仓库的配置

```bash
git remote -v
git remote add github url
git push -u github master

# 合并远程和本地分支的代码
git pull github master
git pull origin master

# 删除
git remote rm github
```

## 常用命令

```bash
# git 撤销add的操作
git reset HEAD 文件名
```

回滚：

Git回滚代码到某个commit 回退命令：

`git reset --hard HEAD^` 回退到上个版本

`git reset --hard HEAD~3` 回退到前3次提交之前，以此类推，回退到n次提交之前

`git reset --hard commit_id` 退到/进到，指定commit的哈希码（这次提交之前或之后的提交都会回滚）

回滚后提交可能会失败，必须强制提交

强推到远程：(可能需要解决对应分支的保护状态)

`git push origin HEAD --force`
