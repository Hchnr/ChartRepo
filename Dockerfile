FROM registry.cn-beijing.aliyuncs.com/shannonai/debian
LABEL maintainer="hechenrui123@gmail.com"

RUN apt-get update && apt-get install -y wget && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY release release
COPY update.sh update.sh
COPY .git .git
COPY entrypoint.sh entrypoint.sh
COPY ./file_server file_server
RUN chmod u+x file_server && chmod u+x entrypoint.sh && chmod u+x update.sh

EXPOSE 9421

ENTRYPOINT ["./entrypoint.sh"]
CMD ["file_server"] # set default arg for entrypoint
