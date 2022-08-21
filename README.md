# Deepin wine for Ubuntu 22.04

基于wszqkzqk的[deepin-wine-ubuntu](https://github.com/wszqkzqk/deepin-wine-ubuntu)项目修改，与zq1997的[deepin-wine](https://github.com/zq1997/deepin-wine)项目完全兼容，可使用zq1997的软件源更新本项目提供的软件包

**建议优先使用zq1997的方案，当某个软件使用zq1997的方案遇到问题时，再使用本项目。本项目仅测试过QQ（9.1.8 容器 + 9.6.5.28778 版本）。**

已知能成功运行的系统：

* Kubuntu 22.04（截至 2022.08.17）
* 其它发行版及桌面环境待测试，其他桌面环境的 Ubuntu 理论上都可用

**如果你在其他Ubuntu版本或其他桌面环境成功安装并运行，请通过[邮箱](mailto:vvvbbbcz@163.com)告知我，以便我更新此列表。**

## 一、项目介绍

>通过将 wszqkzqk 项目的软件包的依赖进行更新，从而解决原项目在 Ubuntu 22.04 下的依赖问题。
>
>仅供个人研究学习使用
>
>刚刚适配 Ubuntu 22.04，可能在安装或运行上还存在问题,欢迎反馈！
>
>Gitee 用户遇到问题请尽量到 Github 集中反馈或讨论，Gitee 仓库主要仅作加速访问存档功能
>
>声明：
>因为使用本仓库的任何内容所导致的任何后果与本人无关，若你无法对使用该仓库后的任何后果负责，请不要使用本仓库的任何内容。
>本仓库所有者不拥有该仓库任何二进制文件的版权，所有由本人编写的非二进制文件以 GPL-3.0 开源协议开源。若该仓库的文件侵犯了您的法律权益，请联系 vvvbbbcz@163.com，我会删除侵权内容并道歉。
>该项目得以实现的全部功劳来自于深度操作系统开发人员的辛勤努力，本人只是将其成果适配到 Ubuntu/Debian 平台以让这一伟大成果能为更多人所共享，本人对深度操作系统的开发人员致以崇高的敬意。
>
>另外，感谢 wszqkzqk 对 deepin-wine 的相关软件包进行整理与发布，使得本项目得以实现。

## 二、使用教程

### 安装教程

1. 克隆或下载本仓库。
2. 切换到仓库文件目录，在终端中运行 `./install.sh`。
3. 如果程序运行后出现 X 错误，则需要运行 `kde-fix.sh` 脚本
4. 如果运行出现 `libwine.so.1: No such file or directory` 的错误，需要执行 `fix-link.sh` 修复。

### 卸载方法

1. 执行 `uninstall.sh`。
2. 如果你之前使用过 `kde-fix.sh` 脚本，则需要再运行如下命令：`rm ~/.config/autostart-scripts/gsd-xsettings.sh` 并移除 `gnome-settings-daemon` 和 `gcc` 软件包（**如果移除这两个软件包会破坏其他软件包，则无需移除**）

### 使用说明

下载并安装所需要的 wine 容器**（建议在终端下使用dpkg -i安装容器，否则容易误报依赖错误）**

可使用deepin发布的容器安装包：

1. [QQ](http://packages.deepin.com/deepin/pool/non-free/d/deepin.com.qq.im/)
2. [TIM](http://packages.deepin.com/deepin/pool/non-free/d/deepin.com.qq.office/)
3. [QQ轻聊版](https://packages.deepin.com/deepin/pool/non-free/d/deepin.com.qq.im.light/)
4. [微信](http://packages.deepin.com/deepin/pool/non-free/d/deepin.com.wechat/)如果出现依赖错误，请下载[这个版本](https://gitee.com/wszqkzqk/deepin-wine-containers-for-ubuntu/raw/master/deepin.com.wechat_2.6.8.65deepin0_i386.deb)
5. [Foxmail](https://packages.deepin.com/deepin/pool/non-free/d/deepin.com.foxmail/)

其它 deepin-wine 容器：[deepin软件仓库下载](https://packages.deepin.com/deepin/pool/non-free/d/)

### GNOME桌面的托盘

GNOME桌面环境的托盘可能会变成悬浮窗口，需要安装 Gnome Shell 插件：[TopIcons Plus](https://extensions.gnome.org/extension/1031/topicons/)

### 手动更改配置（winecfg）

执行 `WINEPREFIX=~/.deepinwine/容器名称 deepin-wine winecfg` 即可，也可以用此方法来调整缩放问题，亦可用此方法更新容器内软件版本。

### [wine 应用程序全局快捷键无效的解决方案](https://blog.diqigan.cn/posts/wine-global-hotkey-problem.html)

#### 1. 安装 xdotool

直接在命令行运行以下命令即可: 

```shell
sudo apt install --no-install-recommends xdotool
```

#### 2. 编写 xdotool 脚本

*思路: Wine 应用在后台无法接收到快捷键状态, 此时借助 xdotool 向 Wine 应用发送模拟按键信息即可. * 

在合适的位置新建一个脚本文件 "open_wechat.sh", 写入以下内容: 

```shell
#!/bin/sh
# 在当前运行的应用中找到名为WeChat.exe的应用程序，并向它发送按键事件"ctrl+alt+W"
# WeChat的可执行文件名为WeChat.exe，如果是其它应用程序就修改成其它应用程序的可执行文件名, 应用名称大小写敏感, 一个字母都不能错!
xdotool key --window $(xdotool search --limit 1 --all --pid $(pgrep WeChat.exe)) "ctrl+alt+W"
```

赋予脚本可执行权限: 

```shell
chmod +x open_wechat.sh
```

如果此时你的微信正好运行在后台, 执行这个脚本就可以把它召唤到前台. 如果没有, 请检查脚本是否有错误. 

#### 3. 设置快捷键

图形界面依次打开 "设置" -> "设备" -> "键盘", 点击列表最底部的 "+" 号添加自定义快捷键. 

![快捷键设置](https://images.gitee.com/uploads/images/2020/0117/075141_4d17fab4_1442530.png)

* 名称随便, 填写 "打开微信" 即可; 
* 命令填写刚才编写的脚本的**全路径**;
* 快捷键设置自己想用的快捷键即可, 建议于应用内部快捷键相同; 
* 最后点击"添加"即可. 

#### 4. 验证

到这里已经设置成功了, 打开微信, 切换到后台, 然后按下刚才设置的快捷键就能召唤应用至前台. 如果不能, 请检查自己前面的设置是否有误. 

### 问题记录及解决方案

#### 微信无法发送图片

```shell
sudo apt-get install libjpeg62:i386
```

## 三、参与贡献

* 1. Fork 本项目
* 2. 新建 Feat_xxx 分支
* 3. 提交代码
* 4. 新建 Pull Request
* 5. [捐赠deepin](https://bbs.deepin.org/forum.php?mod=viewthread&tid=40784&extra=page%3D1)

欢迎大家积极反馈！
