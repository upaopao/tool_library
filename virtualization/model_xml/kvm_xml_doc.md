# KVM-OS配置文档



## 一、xml文件说明

| Name               | Description         | Parameter           | Status |
| ------------------ | :------------------ | :------------------ | :----- |
| vemerge分支          |                     |                     |        |
| vemerge-base.xml   | 基于Yourun的文件模板       | 原生参考文件              | 不可用    |
| vemerge-nested.xml | 基于vemerge-base.xml  | 修改了参数配置             | 已可用    |
|                    |                     |                     |        |
| ubuntu分支           |                     |                     |        |
| ubuntu14-base.xml  | 基于ubuntu14.04创建的模板  | 原生文件,仅注释domstatus参数 | 已可用    |
| uwin10.xml         | 基于ubuntu14-base.xml | 在其基础上进行参数定制         | 已可用    |
|                    |                     |                     |        |
| centos分支           |                     |                     |        |
| centos7-base.xml   | 基于cetnos7.5创建的模板    | 原生参考文件              | 不可用    |
| cwin10.xml         | 基于centos7-base.xml  | 注释domstatus参数,参数定制  | 已可用    |
|                    |                     |                     |        |
| net分支              |                     |                     |        |
| netos.xml          | 源于网络模板文件            | 参数修改                | 已可用    |
|                    |                     |                     |        |
| 子模块                |                     |                     |        |
| network-base.xml   | network的参数配置        | 仅做参数参考              | 不可用    |
|                    |                     |                     |        |


## 二、参数定制

* Bridge Network


## 三、扩展备注

* uwin10.xml
  运行于ubuntu系统之上

* cwin10.xml
  运行于centos系统之上
* 定制修改
  新的配置修改,应于 `uwin10.xml` 与 `cwin10.xml` 文件基础上进行修改定制.
  参数改动较大的时候,先备份原文件.






