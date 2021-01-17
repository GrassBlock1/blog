---
layout:
title: pagermaid - 将你变为人形自走bot
date: 2020-07-26 11:36:37
tags:
---
<link rel="stylesheet" href="https://cdnjs.loli.net/ajax/libs/mdui/0.4.3/css/mdui.min.css">
<script src="https://cdnjs.loli.net/ajax/libs/mdui/0.4.3/js/mdui.min.js"></script>

_重要：本文只起到抛砖引玉的作用，可能不提供售后服务（大嘘_
_感谢 @flyingsky 大佬提供的排版改进_

2020.06.07 更新 增加了无root查看配置&仅termux成功的实例（

目录

[TOC]

# <i class="mdui-icon material-icons">description</i> 介绍
> 通过 PegerMaid 您可以将自己变为人形自走 Bot，本项目功能的自由定制度高，可全方位协助聊天，帮助您更好的使用 Telegram。_来自 @Pagermaid_modfiy_
# <i class="mdui-icon material-icons">&#xe87b;</i> 主要功能
帮助你通过命令设置自己的个人信息，自动已读对话，自动回复（需要插件），消息辅助，偷取贴纸（✨），还有广泛的插件扩展！
更多详见 <a href="https://telegra.ph/PagerMaid-Modify-README-05-02"><button class="mdui-btn mdui-ripple">非官方文档</button></a>
# <i class="mdui-icon material-icons">build</i> 着手安装
为了更好的中文支持和体验，我们这里选择 Pagermaid-modfiy来安装。

<div class="mdui-card">
  <div class="mdui-card-media">
    <img class="mdui-img-circle" src="https://avatars0.githubusercontent.com/u/19620655?s=400&u=30eb84566ae5c71f3dc9d98e953d6aa2fb5eaf8c&v=4"/>
    <div class="mdui-card-media-covered">
      <div class="mdui-card-primary">
        <div class="mdui-card-primary-title">Pagermaid-Modify</div>
        <div class="mdui-card-primary-subtitle">PagerMaid Telegram utility daemon.</div>
      </div>
        <a href="https://github.com/xtaodada/PagerMaid-Modify"><button class="mdui-btn mdui-ripple mdui-ripple-white">打开GitHub项目</button></a>
      </div>
    </div>
  </div>
</div>

## 安装前的准备
- 一台Ubuntu （应该是越新越好）的虚拟服务器/Termux（指能连接到Telegram服务器的手机）（别问我为啥是Ubuntu,别的系统安装时问题太多（
- 一个Telegram账户
- 一个聪明可爱，动手能力强的你（雾
- 一个 Telegram api key&hash  <button class="mdui-btn mdui-ripple mdui-color-theme-accent" mdui-dialog="{target: '#exampleDialog'}" mdui-tooltip="{content: '获取相关帮助'}">如何申请？</button>

<div class="mdui-dialog" id="exampleDialog">
  <div class="mdui-dialog-title">帮助</div>
  <div class="mdui-dialog-content">前往 https://my.telegram.org/apps 并登录自己的账号，然后输入你喜爱的name &shortname即可</div>
  <div class="mdui-dialog-actions">
    <button class="mdui-btn mdui-ripple" mdui-dialog-close>前往</button>
    <button class="mdui-btn mdui-ripple" mdui-dialog-confirm>好的</button>
  </div>
</div>

> 顺便一提，如果你的Ubuntu里没有装Python3，你还需要 `apt install python3` （这也会将pip3安装到你的Ubuntu）

## 使用虚拟服务器
首先 clone 该仓库的源码

`git clone https://github.com/xtaodada/PagerMaid-Modify /var/lib/pagermaid （建议）`

之后请打开这个目录（/var/lib/pagermaid） 找到 config.gen.yml，将文件 config.gen.yml 复制一份到 config.yml ，并使用您最喜欢的文本编辑器，编辑配置文件，直到您满意为止。

然后使用pip3安装下面的依赖：
```
psutil
pyqrcode
pypng
pyzbar
emoji
email_validator
youtube_dl
pyyaml
redis
coloredlogs
requests
pytz
cowpy
googletrans
beautifulsoup4
gtts
gtts-token
wordcloud
telethon
pillow
python-magic
pygments
distutils2-py3
speedtest-cli
gitpython
werkzeug
flask
flask_sqlalchemy
flask_login
flask_bcrypt
flask_wtf
wtforms
cheroot
```
啥？你告诉我一个一个很麻烦？那就直接

`pip3 -m requirements.txt`

等待安装完成（由于耗时较长建议套入 screen 里，如果没有请安装screen： `apt install screen` 安装后运行 `screen -S pagermaid（此处名字随意）`

安装后再（在 screen 里）输入 python3 -m pagermaid 并跟着提示操作就完成了！
## 使用Termux
> 说明一下：如果你的网络不能访问Telegram的话，需要挂梯子，并且你需要termux在后台长久运行，并且此方法尚待检验。
首先进入 Ubuntu （如果已经安装了）
然后跟着上面的步骤就好了（

如果你还没有安装，可以接着看（而非跳到下一节）：
首先输入此指令：
```
pkg install wget openssl-tool proot -y && hash -r && wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh && bash ubuntu.sh 
```

这将会把 Ubuntu 安装到您的系统，之后您可以使用 ./start-ubuntu.sh 指令来启动系统。
启动系统之后就可以跟着上面的步骤安装了（


> 根据 @KuoHuanHuan 的说法，不进入Ubuntu也可以成功，不过需要逐个手动安装依赖，也请自行测试（

**如果你没有root权限，你可能无法访问你的pagermaid目录！ 那么请使用 `vim /var/lib/pagermaid/config.yml` 来复制、编辑（略不友好）** <button class="mdui-btn mdui-ripple mdui-color-theme-accent" mdui-dialog="{target: '#example'}">我该如何使用vim？</button>

<div class="mdui-dialog" id="example">
  <div class="mdui-dialog-title">快捷指令图解</div>
  <div class="mdui-dialog-content">下面有张图供你参考（来自x度百科，侵权请联系） <img src="https://i.loli.net/2020/06/07/UmjaJY2u9plbqPW.png" width="70%" height="70%"> 
  </div>
  <div class="mdui-dialog-actions mdui-dialog-actions-stacked">
    <button class="mdui-btn mdui-ripple">取消</button>
    <button class="mdui-btn mdui-ripple">好</button>
  </div>
</div> 

<div class="mdui-typo"><mark>如果你不想用vim（或者觉得vim操作繁琐），请看下面</mark></div>

首先在**安装之前**输入 `sshd && whoami` 以获取身份信息（
然后输入 `passwd` 以设置一个密码（记得要输两次相同的密码！_建议设置易记的密码_）
> 其实此处就是为了开启sftp服务，方便管理文件（

打开你的文件管理器（比如 solid explorer） 添加一个sftp链接并按照下图步骤。

![第一步](http://image.coolapk.com/feed/2020/0409/23/1419933_cdf4ec48_5713_7897@1080x2340.jpeg.m.jpg)

进入后，点右下的 **＋**
按图输入即可😉

![第二步](http://image.coolapk.com/feed/2020/0409/23/1419933_c97b66e6_5713_7899@1080x1424.jpeg.m.jpg)

![第三步](http://image.coolapk.com/feed/2020/0409/23/1419933_99db46da_5718_8225@1080x1241.jpeg.m.jpg)

![第四步](http://image.coolapk.com/feed/2020/0409/23/1419933_75b0b353_5718_8227@1080x1110.jpeg.m.jpg)

然后同意密钥即可。

之后打开 /Ubuntu-fs/var/lib/pagermaid 找到配置（config.gen.yml）文件并复制为config.yml并编辑，保存即可。


# 总结
嗯 教程到这里就结束了，其间可能会有错误 欢迎在评论区里指正，我将会实时修改。
写的也有些草草了事，更详细的教程欢迎<a href="https://likeai.me/archives/69/"><button class="mdui-btn mdui-color-theme-accent mdui-ripple">到这里查看</button></a>
# 注意事项
非常重要！用ssh连接的一定要进行进程守护（或者套进screen等容器）！（[原因看这里](https://www.ibm.com/developerworks/cn/linux/l-cn-screen/index.html)）

建议将错误日志发送至[反馈群组](https://t.me/PagerMaid_Modify/3)以获得反馈（

<a onclick="mdui.snackbar({message: '感谢你的阅读',buttonText: '好',onClick: function(){mdui.alert('你点错了（')},onButtonClick: function(){mdui.alert('再次表达感谢！也欢迎在评论区留言反馈！')},})" class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-theme-accent">好的</a>



