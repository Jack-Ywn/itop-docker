## 使用[docker](https://hub.docker.com/repository/docker/jackywn/itop)部署

```shell
#创建带有卷的MariaDB容器
docker run \
--name itop-db \
--hostname itop-db \
-e MARIADB_ROOT_PASSWORD="abc123%%" \
-e MARIADB_DATABASE="itop" \
-e MARIADB_USER="itop" \
-e MARIADB_PASSWORD="itop" \
-v /data/itop/mariadb:/var/lib/mysql \
-d mariadb:10.7

#运行itop容器并且链接数据库
docker run \
--name itop-www \
--hostname itop-www \
--link itop-db:itop-db \
-v /data/itop/www:/app \
-p 8000:80 \
-e VERSION_ITOP=3.0.0 \
-e PHP_POST_MAX_SIZE=100M \
-d jackywn/itop
```

## 使用docker-compose部署

```shell
#全新环境初始化部署
git clone https://github.com/Jack-Ywn/itop-docker.git
cd itop-docker
docker-compose up -d

#访问http://ip:8000即可初始化安装iTop
```

## 构建容器镜像

```shell
git clone https://github.com/Jack-Ywn/itop-docker.git
cd itop-docker/build
docker image build -t "jackywn/itop" .
```

## Nginx反向代理itop容器

```shell
server {
    listen 80;
    listen 443 ssl http2;

    server_name                example.com;
    server_name_in_redirect    on;
    port_in_redirect           on;

    if ( $scheme = http ) { return 301 https://$host$request_uri; }

    ssl_certificate          example.com.cer;
    ssl_certificate_key      example.com.key;

    location / {
        proxy_pass  http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Port $server_port;
    }
}
```





```
docker run --name web -v /root/itop:/app -p 80:80 -e PHP_POST_MAX_SIZE=100M -e VERSION_ITOP=3.0.0 -d jackywn/itop

docker run --name web -v /root/itop:/app -p 80:80 -d jackywn/itop
```

