FROM registry.cn-hangzhou.aliyuncs.com/deveops/oneapm-agent:sdk-1.8-base
MAINTAINER Reworld <m13732916591_1@163.com>
ENV STAND_ALONE=""
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["start.sh"]