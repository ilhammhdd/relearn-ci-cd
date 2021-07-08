podman build -f Containerfile --build-arg REST_PORT=8989 --build-arg INS_NUM=1 -t ilhammhdd/relearn-ci-cd:alpine-golang-arm64v8 .
podman run -dit --restart=always --name relearn-ci-cd-1 -p 8989:8989 localhost/ilhammhdd/relearn-ci-cd:alpine-golang-arm64v8
