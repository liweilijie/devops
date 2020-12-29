# merge 常用操作

## merge 中断
```git
git merge --abort
```

## merge的时候全部采用某一个端的文件
在Git使用过程中，有的时候进行 `merge`，可能需要会全部采用某一端的文件，换句话说，就是完全采用本地的，或者完全采用远程的，怎么实现这个功能呢？ 

使用`merge`命令：
```bash
# keep remote files
git merge --strategy-option theirs

# keep local files
git merge --strategy-option ours
```

## git pull 采用某一个端的文件
```git
git pull -X theirs

git pull https://github.com/filestar-project/filecoin-ffi.git -X theirs
```

## 参考 

- [https://blog.walterlv.com/post/git-merge-strategy.html](https://blog.walterlv.com/post/git-merge-strategy.html)
- [https://developer.aliyun.com/article/756021](https://developer.aliyun.com/article/756021)

