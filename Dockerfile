FROM dhi.io/golang:1.26.6-debian13-dev@sha256:08ff7030d9e3aa25230a57f6437e83ffe33995b9c88b0dfcab4f076ad3cc8f6c AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.6-debian13-dev@sha256:08ff7030d9e3aa25230a57f6437e83ffe33995b9c88b0dfcab4f076ad3cc8f6c

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
