用go实现的简单的webservice: file_server

主要用于发布helm所需要的charts 

1. 执行 `go build ./file_server.go`
2. 执行 `docker build --rm -t file_server .`
3. 执行 `docker tag file_server registry.cn-beijing.aliyuncs.com/shannonai/file_server:v1.0.0`
4. 执行 `docker-compose up -d`

还可以执行`docker-compose up -d --scale file_server=3` 对file_server进行扩展
