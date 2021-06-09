FROM golang:latest

WORKDIR $GOPATH/src/github/denisdugar/web-books

ADD . .

RUN apt-get update && apt install -y build-essential

RUN go get -d -v ./...
RUN go install -v ./...

EXPOSE 8080

RUN go build
CMD ./go-webapp-sample
