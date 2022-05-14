# PHP-Remote-Docker-Debugging

## 简介

一个用于远程调试PHP的Docker镜像（随用随弃）

## 镜像介绍

目前，该镜像已经发布于DockerHub中，如果您十分熟练，可以直接pull下来搭建使用

- https://hub.docker.com/repository/docker/lxxxin/apline-ssh-php74/general

镜像相关信息：

- 内部端口：80（Web服务），22（SSH服务）
- 环境变量：ROOT_PASSWORD（root用户登录密码）
- 架构：linux/amd64
- PHP版本：PHP7.4.29

## 使用场景

如果您需要在远程服务器调试一个PHP应用程序，但是并且需要使用SSH进行连接调试，那么这个项目可能会很适合您。

通常，我们会使用VS Code进行调试，因为VS Code中的Remoet - SSH插件十分适合远程调试。

## 使用方法

首先，您需要有一台带有公网IP的云服务器，并且确保需要使用的端口处于放行状态，否则，您可能会遇到无法连接的问题

在拥有一台云服务器之后，切换至root用户，输入下方命令之后，输入相应的密码即可

```shell
su root
```

然后，确保云服务器已经安装了Docker，如果没有安装，可以使用下方的命令进行安装

```shell
apt-get update && apt-get install docker.io
```

接着将镜像拉到（pull）本地

```shell
docker pull lxxxin/apline-ssh-php74
```

然后将容器启动，下方的命令相关参数意思如下：

- 45678:80 将容器内部的80端口映射到宿主机45678端口，其中45678可以自行修改
- 12222:22 将容器内部的22端口映射到宿主机12222端口，其中12222可以自行修改
- ROOT_PASSWORD=thisismypassword 设置root用户的登录密码，自行设置，建议使用复杂度较高的密码，否则可能会遭遇攻击

```shell
docker run -it -d -p 45678:80 -p 12222:22 -e ROOT_PASSWORD=thisismypassword lxxxin/apline-ssh-php74
```

如果一切顺利的话，访问`http://ip:45678`，就可以看到phpinfo页面了

![image-20220514121751806](https://lxxx-markdown.oss-cn-beijing.aliyuncs.com/pictures/202205141217915.png)

接着打开VS Code，安装`Remote - SSH` 插件

![image-20220514121943190](https://lxxx-markdown.oss-cn-beijing.aliyuncs.com/pictures/202205141219268.png)

添加一个SSH连接，命令格式为：`ssh root@ip -p port`

![image-20220514122455383](https://lxxx-markdown.oss-cn-beijing.aliyuncs.com/pictures/202205141224420.png)

然后选择在新窗口中打开，第一次连接会有下方弹窗，选择continue即可

![image-20220514123035571](https://lxxx-markdown.oss-cn-beijing.aliyuncs.com/pictures/202205141230600.png)

输入密码，密码为前面启动容器时配置的ROOT_PASSWORD的值

![image-20220514123114005](https://lxxx-markdown.oss-cn-beijing.aliyuncs.com/pictures/202205141231043.png)

接下来您可以打开网站目录`/var/www/html/`进行配置，如果出现了下方的提示，选择Trust即可

![image-20220514123707381](https://lxxx-markdown.oss-cn-beijing.aliyuncs.com/pictures/202205141237417.png)

然后接下来就可以进行您的测试操作了

![image-20220514123828076](https://lxxx-markdown.oss-cn-beijing.aliyuncs.com/pictures/202205141238123.png)
