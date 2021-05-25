FROM golang:latest

WORKDIR $GOPATH/src/github/denisdugar/web-books

ADD . .

RUN apt-get update && apt-get install -y apt-transport-https
RUN apt install build-essential
RUN go build
