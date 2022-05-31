FROM ubuntu:latest
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install sudo wget curl tar zip unzip jq goxkcdpwgen  -y
RUN apt-get upgrade -y
RUN apt install ssh nginx -y
COPY ./start.sh ./
COPY ./defundd /usr/local/bin/
CMD sed -i 's/\r//' start.sh && ./start.sh