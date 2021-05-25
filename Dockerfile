FROM golang:latest

WORKDIR $GOPATH/src/github/denisdugar/web-books

ADD . .

#RUN apt-get update && apt-get install -y apt-transport-https
#RUN apt install -y build-essential

RUN go get -d -v ./...
RUN go install -v ./...

EXPOSE 8081

CMD go build
