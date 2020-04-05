# From GUI to CLI

## 实验要求

- 上传本人亲自动手完成的vimtutor操作全程录像

## 软件环境

- Ubuntu18.04 Server

  - 网卡：NAT、Host-Only
  
  - 镜像：ubuntu-18.04.4-server-amd64.iso

- 安装 asciinema

```bash
# Install
sudo apt install asciinema

# Link your install ID with your asciinema.org user account
asciinema auth
```

## vimtutor 操作录像

### Lesson-1

[![asciicast](https://asciinema.org/a/316698.svg)](https://asciinema.org/a/316698)

### Lesson-2

[![asciicast](https://asciinema.org/a/316736.svg)](https://asciinema.org/a/316736)

### Lesson-3

[![asciicast](https://asciinema.org/a/316738.svg)](https://asciinema.org/a/316738)

### Lesson-4

[![asciicast](https://asciinema.org/a/316741.svg)](https://asciinema.org/a/316741)

### Lesson-5

[![asciicast](https://asciinema.org/a/316744.svg)](https://asciinema.org/a/316744)

### Lesson-6

[![asciicast](https://asciinema.org/a/316746.svg)](https://asciinema.org/a/316746)

### Lesson-7

[![asciicast](https://asciinema.org/a/316749.svg)](https://asciinema.org/a/316749)

## 自查清单

### vim有哪几种工作模式

- Normal
- Insert
- Visual
- Select
- Command-line
- Ex-mode

### Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行?

- 一次向下移动光标10行：`10j`
- 快速移动到文件开始行：`gg`
- 快速移动到文件结束行：`G`
- 快速跳转到文件中的第N行：`NG`

### Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

- 删除单个字符：`x`
- 删除单个单词：`dw`
- 从当前光标位置一直删除到行尾：`d$`
- 删除单行：`dd`
- 删除当前行开始向下数N行：`Ndd`

### 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

- 快速插入N个空行：`NO ESC`
- 快速插入80个-：Normal模式下 `80i- ESC`

### 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作

- 撤销最近一次编辑操作：`u`
- 重做最近一次被撤销的操作：`Ctrl-R`

### vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢

- 剪切单个字符：`x`
- 剪切单个单词：`dw`
- 剪切单行：`d$`
- 粘贴：`p`

### 为了编辑一段文本你能想到哪几种操作方式？

- 输入欲添加文本：`A`
- 替换当前光标到单词的末尾的内容：`ce`
- 替换当前光标到行末的内容：`c$`
- 输入欲插入文本：`i`
- 在光标的上方打开新的一行并进入插入模式：`O`
- 在光标的下方打开新的一行并进入插入模式：`o`
- 连续替换多个字符：`R`
- 删除光标所在位置的字符：`x`
- 复制文本：`y`
- 粘贴文本：`p`

### 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法

- `Ctrl-G`

### 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换

- `/pattern` 、 `?pattern` 设pattern为待查找词
- `:set ic`                忽略大小写
- `:set hls is`            高亮显示搜索结果
- `:%s/old/new/g`          将当前文件中old全部替换为new

### 在文件中最近编辑过的位置来回快速跳转的方法

- `CTRL-O`
- `CTRL-I`

### 如何把光标定位到各种括号的匹配项？例如：找到\(, \[, or \{对应匹配的),], or }

- 将光标置于待匹配的括号处，输入`%`

### 在不退出vim的情况下执行一个外部程序的方法

- `:!command`
  - :!ls
  - :!rm FILENAME

### 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标

- `:help [快捷键]`       查询内置默认快捷键的使用方法

- `Ctrl-W`              在窗口之间跳转
