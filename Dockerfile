FROM golang:alpine AS builder
RUN echo "nobody:x:65534:65534:nobody:/:" > /etc_passwd
WORKDIR /build
RUN apk add --no-cache git
COPY . .
RUN CGO_ENABLED=0 go build -o app -ldflags '-extldflags "-static"' -tags timetzdata

FROM scratch
COPY --from=builder /build/app /app
COPY --from=builder /etc_passwd /etc/passwd
USER nobody
ENTRYPOINT ["/app"]
