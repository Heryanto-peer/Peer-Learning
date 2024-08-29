# Gunakan golang image sebagai base image
FROM golang:1.20 AS builder

# Set environment variable
ENV GO111MODULE=on

# Buat direktori kerja
WORKDIR /app

# Copy go mod dan go sum files
COPY go.mod go.sum ./

# Download semua dependencies yang di cache dalam layer Docker image
RUN go mod download

# Copy source code ke dalam Docker image
COPY . .

# Build aplikasi
RUN go build -o main .

# Eksekusi aplikasi
CMD ["./main"]
