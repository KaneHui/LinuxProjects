# 100-shell-script-examples #

## prompt-color-using-tput介绍 ##
### 什么是tput？ ###
tput 命令将通过 terminfo 数据库对您的终端会话进行初始化和操作。通过使用 tput，您可以更改几项终端功能，如移动或更改光标、更改文本属性，以及清除终端屏幕的特定区域。

### 什么是 terminfo 数据库？ ###
UNIX 系统上的 terminfo 数据库用于定义终端和打印机的属性及功能，包括各设备（例如，终端和打印机）的行数和列数以及要发送至该设备的文本的属性。UNIX 中的几个常用程序都依赖 terminfo 数据库提供这些属性以及许多其他内容，其中包括 vi 和 emacs 编辑器以及 curses 和 man 程序。

### 参考资料 ###
 

- [linux下tput命令详解](http://blog.51cto.com/297020555/491954)  
- [tput 命令行使用说明](http://blog.csdn.net/fdipzone/article/details/9993961)  

## 011-colors.sh 解析 ##
调用该脚本中的元素可以改变输出的颜色和格式，比如将字体颜色变为红色、黑色，进行加粗等。  
用法如下： 
 
	source path-to-011-colors.sh  
	# 初始化
	initializeANSI
	# 调用initializeANSI中定义的各种格式、颜色
	cat << EOF
	${yellowf}This is a phrase in yellow${redb} and red${reset}
	${boldon}This is bold${ulon} this is italics${reset} bye bye
	${italicson}This is italics${italicsoff} and this is not
	${ulon}This is ul${uloff} and this is not
	${invon}This is inv${invoff} and this is not
	${yellowf}${redb}Warning I${yellowb}${redf}Warning II${reset}
	EOF

### 参考资料 ###
 

- [Linux的shell中echo改变输出显示样式](https://www.cnblogs.com/276815076/archive/2011/05/11/2043367.html)  
- [linux shell 的here document 用法 (cat << EOF)](https://my.oschina.net/u/1032146/blog/146941)  


## 036-cgrep.sh 解析 ##
该脚本的用法如下：  

    036.cgrep.sh [-c X] pattern {filename}

- -c 表示context，X为context的值，可以写成-c 2或者 -c2 两种格式
- pattern表示需要匹配的模式
- filename表示文件名  
假设X的值为3，pattern匹配到的字段所在的行号为10，则该命令可以显示7-13行的内容，即（10-3）-(10+3),同时对匹配字段进行加粗，相当于显示匹配字段的上下文；如果X的值小于1，则直接显示匹配行。  

下面对脚本中的一些命令进行分析：
 
	# \\ 表示对\进行转义 
	esc="\\330"  
	# 对字段进行加粗
	bOn="${esc}[1m"
	# 取消字段加粗效果
	bOff="${esc}[22m"
	# 在第prev行前插入'----'
    echo "${prev}i\\" >> $sedscript
    echo "----" >> $sedscript  

### 参考资料 ###
 
>

- [linux中强大且常用命令：find、grep](https://www.cnblogs.com/skynet/archive/2010/12/25/1916873.html)  
- [Linux 三剑客之 sed 命令](https://blog.csdn.net/csuwubing/article/details/79238221)  
- [trap命令](http://man.linuxde.net/trap)

## 037-zcat.sh 解析 ##
该脚本的用法如下：  

    037-zcat.sh filenames  
- filenames,表示需要解压的文件，可以有多个  

我们需要将该脚本链接到3个不同的名字上，zcat、zmore、zgrep，执行的过程中我们会遍历所有命令行上的文件名，检查其末尾是否为.Z、.gz、.bz2，若是，则对其进行解压，并将文件的后缀去掉，再添加到对应的list中，比如test1.gz,test2.Z,test3.bz2的后缀去掉后变成test1、test2、test3，通过zcat、zmore或者zgrep命令查看（test1,test2,test3），执行完之后再重新将文件进行压缩。
	
	unZ="uncompress"  ;  Zlist=""
	# 解压文件
	$unZ "$arg"
	# 去掉压缩文件的后缀
	arg="$(echo $arg | sed 's/\.Z$//')"
	# 将去掉后缀的压缩文件添加到list中
    Zlist="$Zlist \"$arg\""
	# 执行"cat test1|test2|test3"
	eval  cat $newargs  

### 参考资料 ###
 
>
- [[Linux]eval命令的使用](https://blog.csdn.net/her__0_0/article/details/65938894)
- [每天一个linux命令（35）：ln 命令](http://www.cnblogs.com/peida/archive/2012/12/11/2812294.html)
	


## 038-bestcompress.sh 解析 ##
该脚本的用法如下：  

	038-bestcompress.sh [-a] filenames  
- -a 该参数表明，如果filename是一个已经压缩过的文件，还会对其进行进一步压缩。如果不加这个参数，则会略过已经压缩过的文件。
    
脚本会使用compress、gzip、bzip2三个压缩工具来压缩同一个文件，并将压缩后最小的版本告诉用户。  
	
	# NR可以理解为Number of Record的缩写。
	smallest="$(ls -l "$name" $Zout $gzout $bzout | awk '{print $5"="NR}' | sort -n | cut -d= -f2 | head -1)"



### 参考资料 ###

- [awk内建变量示例详解之NR、FNR、NF](http://www.letuknowit.com/topics/20120329/sample-about-awk-build-in-variable-nr-fnr-nf.html/)


**039-fquota.sh 解析**





**043-mkslocate.sh 解析**

### 参考资料 ###
 
>



- [locate 工作原理](https://blog.csdn.net/Toormi/article/details/50993874)
- [locate 数据库权限分析](https://blog.csdn.net/Toormi/article/details/51137888)




 
- [Shell正则表达式](http://www.jb51.net/tools/shell_regex.html)  


- [(())与()还有${}差在哪？](http://wiki.jikexueyuan.com/project/13-questions-of-shell/eight.html)

 