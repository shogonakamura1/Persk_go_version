FROM golang:1.23.0-alpine AS builder

WORKDIR /app

COPY backend/go.mod backend/go.sum .
RUN go mod download

COPY backend/. .

RUN CGO_ENABLED=0 GOOS=linux go build -v -o /app/main .

FROM alpine:latest

COPY --from=builder /app/main /main

EXPOSE 8080

CMD ["/main"]