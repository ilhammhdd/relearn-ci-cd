ARG ARCH=

FROM ${ARCH}golang:1.15-alpine AS build-env

RUN apk update
RUN apk upgrade
RUN apk add build-base
WORKDIR /go/src/github.com/ilhammhdd/relearn-ci-cd/
COPY . /go/src/github.com/ilhammhdd/relearn-ci-cd/
RUN go mod tidy
RUN go build -o relearn_ci_cd

FROM ${ARCH}alpine

ARG REST_PORT
ARG INS_NUM

ENV REST_PORT=$REST_PORT
ENV INS_NUM=$INS_NUM

COPY --from=build-env /go/src/github.com/ilhammhdd/relearn-ci-cd/relearn_ci_cd .

EXPOSE $REST_PORT

ENTRYPOINT ./relearn_ci_cd
