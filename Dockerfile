FROM golang:1.17.5-alpine3.15
LABEL HyunSang Park <parkhyunsang@kakao.com>

RUN apk update & apk upgrade 
RUN apk --no-cache add ca-certificates wget bash xz-libs git
WORKDIR /tmp
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
RUN tar -xvJf  ffmpeg-release-amd64-static.tar.xz
RUN cd ff* && mv ff* /usr/local/bin

WORKDIR /

ENTRYPOINT ["/bin/bash"]