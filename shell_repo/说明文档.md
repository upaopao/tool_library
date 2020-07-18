# 脚本说明文档(2018-04.10)



## 一、文件列表

###  1. 文件列表

| Name                                     |       Description       | Dependent File |
| ---------------------------------------- | :---------------------: | :------------- |
| [*说明文档.md](./function/)                  |        脚本说明使用文档         | 1-buildall.sh  |
| [file_monitor.sh](./function/file_monitor.sh) | 监测脚本文件修改状态,自动更新文件修改时间戳  | 1-buildall.sh  |
| [md5value.sh](./function/md5value.sh)    |    检测所有文件MD5值/创建软链接     | 无              |
| [modify_time.sh](./function/modify_time.sh) |    统一修改所有文件的编辑/修改日期     | 无              |
| [setattr.sh](./function/setattr.sh)      | 设置所有文件的attr额外属性(chattr) | 无              |
| [status.sh](./function/status.sh)        |   显示所有主程序及功能程序文件的修改日期   | 无              |
| [test_func.sh](./function/test_func.sh)  |         测试功能程序          | 无              |

