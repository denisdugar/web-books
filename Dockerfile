FROM golang:latest

WORKDIR $GOPATH/src/github/denisdugar/web-books

ADD . .

RUN apt install build-essential
RUN go build
