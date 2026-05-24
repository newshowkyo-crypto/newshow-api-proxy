FROM golang:1.21-alpine AS builder

WORKDIR /app

# Clone new-api repository
RUN apk add --no-cache git && \
    git clone https://github.com/Calcium-Ion/new-api.git . && \
    git checkout main

# Build the application
RUN go build -o new-api .

FROM alpine:latest

WORKDIR /app

# Copy binary from builder
COPY --from=builder /app/new-api .

# Create necessary directories
RUN mkdir -p /app/data

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8000/api/status || exit 1

# Run the application
CMD ["./new-api"]
