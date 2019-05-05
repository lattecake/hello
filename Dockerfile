FROM golang:1.11.9-alpine3.9 AS build-env

ENV GO111MODULE=off
ENV GO15VENDOREXPERIMENT=1
ENV BUILDPATH=github.com/latte/hello
RUN mkdir -p /go/src/${BUILDPATH}
COPY ./ /go/src/${BUILDPATH}
RUN cd /go/src/${BUILDPATH} && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install -v

FROM alpine

COPY --from=build-env /go/bin/hello /go/bin/hello
WORKDIR /home
CMD ["/go/bin/hello"]
