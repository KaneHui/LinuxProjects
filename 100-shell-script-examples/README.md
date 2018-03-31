# 100-shell-script-examples #

## prompt-color-using-tput介绍 ##
### 什么是tput？ ###
tput 命令将通过 terminfo 数据库对您的终端会话进行初始化和操作。通过使用 tput，您可以更改几项终端功能，如移动或更改光标、更改文本属性，以及清除终端屏幕的特定区域。

### 什么是 terminfo 数据库？ ###
UNIX 系统上的 terminfo 数据库用于定义终端和打印机的属性及功能，包括各设备（例如，终端和打印机）的行数和列数以及要发送至该设备的文本的属性。UNIX 中的几个常用程序都依赖 terminfo 数据库提供这些属性以及许多其他内容，其中包括 vi 和 emacs 编辑器以及 curses 和 man 程序。

### 参考资料 ###

**命令行**  
>
1 [linux下tput命令详解](http://blog.51cto.com/297020555/491954)  
2 [tput 命令行使用说明](http://blog.csdn.net/fdipzone/article/details/9993961)  
3 [linux中强大且常用命令：find、grep](https://www.cnblogs.com/skynet/archive/2010/12/25/1916873.html)

- [100-shell-script-examples](https://github.com/epety/100-shell-script-examples/blob/master/002-validalnum.sh)  
- [Shell正则表达式](http://www.jb51.net/tools/shell_regex.html)  
- [Linux的shell中echo改变输出显示样式](https://www.cnblogs.com/276815076/archive/2011/05/11/2043367.html)  
- [linux shell 的here document 用法 (cat << EOF)](https://my.oschina.net/u/1032146/blog/146941)  
- [(())与()还有${}差在哪？](http://wiki.jikexueyuan.com/project/13-questions-of-shell/eight.html)
- [trap命令](http://man.linuxde.net/trap)
 