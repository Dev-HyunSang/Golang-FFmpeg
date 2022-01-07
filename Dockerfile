FROM golang:1.17.5-alpine3.15
LABEL HyunSang Park <parkhyunsang@kakao.com>

RUN apk update & apk upgrade 
RUN apk --no-cache add ca-certificates wget bash xz-libs git
WORKDIR /tmp
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
RUN tar -xvJf  ffmpeg-release-amd64-static.tar.xz
RUN cd ff* && mv ff* /usr/local/bin

WORKDIR /

ENV GO111MODULE=on 

WORKDIR /app

# COPY
COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./
COPY . . 

RUN go build -o ffmpeg-golang

EXPOSE 3000

ENTRYPOINT ["./ffmpeg-golang"]