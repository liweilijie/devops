# idea常用 

# 改键

macOs copy

- Find Usages: ctl+\, s
- Back: ctl+t, t
- Search Everywhere: ctl+\, t
- Previous Method: cmd+[
- Go to Declartion or Usages: ctl+]

# other
- Editor->Font: JetBrains Mono  size: 16, Line spacing: 1.2
- Editor->General->Editor Tabs->Tab limit: 40 (更改打开Tab数)
- fond 单独设置一下 console 的字体大小，一般用小一号的字体
- version control->commit->去掉 Use non-modal commit interface 即可显示local changes 窗口


# 插件

- Rainbow Brackets
- IdeaVim
- Markdown
- CodeGlance 代码地图,好用
- Material Theme UI
- Translation
- Toml 为了rust的Cargo.toml
- Active Intellij Tab Hightlighter 高亮当前标签页
- One Dark theme
- Tabnine
- .ignore
- Atom Material Icons
- translation
- RestfulTool2 改键搜索: request service -> `ctl+cmd+/`. java 搜索restful 接口用的.

## 配置

**translation**
 在 tools->Translation 里面引擎选择有道翻译，然后登录：[https://ai.youdao.com/console/#/app-overview](https://ai.youdao.com/console/#/app-overview) 去创建一个 id 和密钥就可以使用。


快捷键是： `ctrl+cmd+u`

# rust

安装代码风格组件 
```bash
rustup component add rustfmt-preview
rustup update 更新所有组件 
cargo fmt
```

## 竖屏

- 先调节显示器设置里面有个纵屏
- 再点系统里面设置，然后点到要竖屏的那个屏，再点集合窗口里面设置旋转90度即可


## IDEA

- 搜索 font 改字体
- search encoding 改为 UTF-8 编码
- autoscroll: Project 里面选择 Always select opened file.
- auto import: 选中: Optimize imports on the fly(会帮我们删除没有用的导入)
- Compiler->Build project automatically 自动编译
- Op+cmd+v: 生成新变量
- shift+cmd+v: 调出历史粘贴板内容
- op+cmd+L: 格式化
- cmd+d: 复制一行并且放到下面
- shift+cmd+o: 查找文件
- shift+shift: 万能查找
- alt+enter: 万能快捷键
  * 见到红色报错的就按这个键
- java 以及热部署
  * 增加devtools 依赖
  * Compiler->Build project automatically 自动编译
  * Advanced Settings -> 选中 Allow auto-make to start even if developed application is currently running
  * 部署好之后，你修改想看效果，可以手动点一下 Build Project 那个小锤子，会立即自动热部署的。
  * 如果idea找不到maven的选项: **右键pom.xml文件, 点击" add as maven project "**
  * 设置JDK: 全局设置在File|New Projects Setup|Structure里面设置JDK. 局部的设置在File|Project Structure里面设置。点击SDKs|右边的加号|Add JDK...|选择你的JDK安装目录增加|然后点击Project选择你要的版本。
