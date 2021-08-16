# PHPDoc php开发

## 简介
phpdoc是一个容器化的php docker开发环境
包含
- php-fpm
- php-worker 
- nginx
- maria-db
- redis-db

## 监控体系

grafana,loki,promtail,node_exporter,prometheus

## 监控体系说明

grafana数据集成看板 - 可对接下方prometheus和loki

http://127.0.0.1:3000/

默认账号为admin,密码为admin

prometheus是性能监控平台

http://127.0.0.1:9090/

promtail是日志收集客户端

loki是日志收集服务端


## 使用说明
将本项目拷贝到自己的项目文件夹
包含env文件夹和docker-compose.yml文件
```bash
#启动所有服务
docker-compose up -d 
#关闭并删除所有服务
docker-compose down 
#重启某一个容器
docker-compose restart {sevice-name} ex: nginx 
#重新构建镜像
docker-compose build {images-name}
```
test
