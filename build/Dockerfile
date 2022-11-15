#基础镜像
FROM webdevops/php-apache:7.4-alpine

#添加拓展
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions xdebug && rm -rf /var/lib/apt/lists/*

#设置工作目录
WORKDIR /app

#配置PHP配置文件
RUN echo post_max_size = 100M >> /opt/docker/etc/php/php.ini && \
    echo date.timezone = Asia/Shanghai >> /opt/docker/etc/php/php.ini && \
    echo session.save_path = /tmp >> /opt/docker/etc/php/php.ini

#配置运行脚本
COPY itop-start.sh /opt/
RUN chmod +x /opt/itop-start.sh
CMD /opt/itop-start.sh

