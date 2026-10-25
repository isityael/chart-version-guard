FROM dhi.io/golang:1.27.3-debian13-dev@sha256:648c1e59a6bb06911d925436caf05f5a1d21d026802553b9ceb9b8bc8031c9de AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.3-debian13-dev@sha256:648c1e59a6bb06911d925436caf05f5a1d21d026802553b9ceb9b8bc8031c9de

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
