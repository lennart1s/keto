# Workaround for https://github.com/GoogleContainerTools/distroless/issues/1342
FROM golang:1.21-bullseye AS builder

RUN apt-get update && apt-get upgrade -y &&\
mkdir -p /var/lib/sqlite &&\
mkdir -p ./internal/httpclient &&\
apt-get install git

RUN git clone https://github.com/lennart1s/keto.git /go/src/github.com/lennart1s/keto

WORKDIR /go/src/github.com/lennart1s/keto
#COPY go.mod go.mod
#COPY go.sum go.sum

#COPY proto/go.mod proto/go.mod
#COPY proto/go.sum proto/go.sum

ENV CGO_ENABLED 1

RUN go mod download

#COPY . .

RUN go build -buildvcs=false -tags sqlite -o /usr/bin/keto .

#########################

FROM gcr.io/distroless/base-nossl-debian12:nonroot AS runner

COPY --from=builder --chown=nonroot:nonroot /var/lib/sqlite /var/lib/sqlite
COPY --from=builder /usr/bin/keto /usr/bin/keto
COPY --from=builder /go/src/github.com/lennart1s/keto/keto.yml /home/nonroot/keto.yml

VOLUME /var/lib/sqlite

EXPOSE 4466 4467

ENTRYPOINT ["keto"]
CMD ["serve"]
