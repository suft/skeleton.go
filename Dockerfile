FROM golang:alpine AS builder
WORKDIR /build
RUN apk add --no-cache git
COPY . .
RUN CGO_ENABLED=0 go build -o app -ldflags '-extldflags "-static"' -tags timetzdata

FROM scratch
COPY --from=builder /build/app /app
USER nobody:nobody /app
ENTRYPOINT ["/app"]
