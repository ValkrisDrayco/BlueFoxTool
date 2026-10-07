FROM alpine:latest
LABEL MAINTAINER="https://github.com/htr-tech/bluephisher"
WORKDIR /bluephisher/
ADD . /bluephisher
RUN apk add --no-cache bash ncurses curl unzip wget php 
CMD "./bluephisher.sh"
