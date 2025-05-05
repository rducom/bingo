FROM golang:1.24.2-bookworm as builder
COPY go.mod /app/
WORKDIR /app
RUN go mod tidy
COPY . .
ENV CGO_ENABLED=0
RUN go build -o /app/bingo
FROM scratch
COPY --from=builder /app/bingo /bingo
COPY phrases.txt templates static /
ENTRYPOINT ["/bingo"]
