<center>
# **LinuxProjects** #
</center>


## prompt-color-using-tput介绍 ##
### 什么是tput？ ###
tput 命令将通过 terminfo 数据库对您的终端会话进行初始化和操作。通过使用 tput，您可以更改几项终端功能，如移动或更改光标、更改文本属性，以及清除终端屏幕的特定区域。

### 什么是 terminfo 数据库？ ###
UNIX 系统上的 terminfo 数据库用于定义终端和打印机的属性及功能，包括各设备（例如，终端和打印机）的行数和列数以及要发送至该设备的文本的属性。UNIX 中的几个常用程序都依赖 terminfo 数据库提供这些属性以及许多其他内容，其中包括 vi 和 emacs 编辑器以及 curses 和 man 程序。

### 参考资料 ###
[linux下tput命令详解](http://blog.51cto.com/297020555/491954)  
[tput 命令行使用说明](http://blog.csdn.net/fdipzone/article/details/9993961)