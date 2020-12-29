# filecoin合并代码相关

## 合并子模块有冲突
正常情况下，如果子模块有更新的话，直接到对应的子模块，[https://www.jianshu.com/p/5264a20a50a2](https://www.jianshu.com/p/5264a20a50a2) 进行git pull url 就可以，如果有冲突的话。有两种方式来处理。
- 第一种是最简单的，将子模块彻底删除了再add一次就会clone最新的
- 第二种情况是到子目录，然后解决冲突，以目标为准

删除子模块:
```bash
# 编辑.gitmodules,删除对应要删除的submodule的行．
# 编辑.git/config,删除有对应要删除的submodule的行．
# 删除 git rm --cached extern/filecoin-ffi
# 删除对应的目录: rm -rf extern/filecoin-ffi
# 删除缓存模块 rm -rf .git/modules/extern/filecoin-ffi

rm -rf extern/filecoin-ffi
vi .gitmodules
vi .git/config
rm -rf .git/modules/extern/filecoin-ffi
git rm --cached extern/filecoin-ffi
git submodule add https://github.com/filestar-project/filecoin-ffi.git extern/filecoin-ffi -b master
git submodule
```

更新完submodules之后再合并主分支：
```git
git fetch filestar
git merge filestar/master
```
