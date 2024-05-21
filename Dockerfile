FROM golang:1.21.10-alpine

RUN apk add --no-cache git build-base
#RUN apk add --no-cache make

WORKDIR /go/src/github.com/lennart1s/keto

RUN git clone https://github.com/lennart1s/keto.git ./

#RUN /usr/bin/make ./Makefile

#CMD [ "touch", "hello-alpine.txt" ]

#ENV GO111MODULE=off
# RUN go get -u github.com/gobuffalo/packr/packr


#RUN GO111MODULE=off go get github.com/gobuffalo/packr/v2/packr2@v2.8.3

#RUN go install github.com/gobuffalo/packr/v2/packr2@v2.8.3

# RUN go get -u github.com/gobuffalo/packr/packr

#ENV GO111MODULE=on

#RUN go mod tidy
#RUN go mod download
#RUN go mod verify

# RUN go get 

#RUN go get github.com/ory/herodot
#RUN go get github.com/ory/keto/cmd
#RUN go get github.com/ory/x/profilex

# RUN go install

# RUN packr

#RUN make

# RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o keto

RUN go build -tags sqlite

CMD [ "go", "run", "./main.go", "serve", "-c", "./keto.yml" ]

#RUN go build

#FROM scratch

#COPY --from=0 /go/src/github.com/lennart1s/keto/keto /usr/bin/keto
#COPY --from=0 /go/src/github.com/lennart1s/keto/keto.yml /keto.yml

#CMD [ "keto", "serve", "-c", "/keto.yml" ]
