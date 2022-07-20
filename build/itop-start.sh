#!/bin/bash

#设置版本变量
[[ ! "$VERSION_ITOP" ]] \
&& VERSION_ITOP=$(curl -s https://api.github.com/repos/Combodo/iTop/releases/latest | grep tag_name | cut -d '"' -f 4)
    
#设置下载URL链接
SRC_ITOP=https://github.com/Combodo/iTop/archive/refs/tags/$VERSION_ITOP.tar.gz

#解压GLPI源代码
if [ "$(ls index.php)" ];
then
    echo "已经安装ITOP"    
else
    wget $SRC_ITOP && tar xf $VERSION_ITOP.tar.gz
    mv iTop-$VERSION_ITOP/* /app && rm -rf iTop-$VERSION_ITOP $VERSION_ITOP.tar.gz
fi

#设置权限
chown -R 1000:1000 /app

#启动服务
/entrypoint supervisord
