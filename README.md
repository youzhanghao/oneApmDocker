# oneApmDocker
实现oneApm探针容器化及可配置化
## 使用方法
1. 作为独立collector使用
~~~
    docker run -it -v /<config-path>/:/opt/config -e STAND_ALONE="yes" registry.cn-hangzhou.aliyuncs.com/deveops/oneapm-agent
~~~ 
_注意_: 因为对collector需要保证-d模式也可运行，故使用了死循环。交互模式需要停止，请使用`docker stop containerId`
2. 作为agent使用
  * Dockerfile内容如下
  ~~~
  FROM registry.cn-hangzhou.aliyuncs.com/deveops/oneapm-agent
  COPY <your jar app> /opt/
  ~~~
~~~
docker run -it -v /<config-path>/:/opt/config -e ONEAPM_AGENT="yes" -e APP_NAME="test_app" -e TIER_NAME="test_tier" -e ONEAPM_KEY="<your key>" <your imageId> 
~~~



