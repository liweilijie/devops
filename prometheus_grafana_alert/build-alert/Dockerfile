# docker build . -t alert -f Dockerfile
# docker run -d -p 8080:8080 -v ./alert:/data alert
FROM ubuntu:20.04
MAINTAINER li wei <liwei@ypool.io>
VOLUME /data
EXPOSE 8080
WORKDIR /data
CMD ["/data/PrometheusAlert"]
