FROM dhi.io/golang:1.26.5-debian13-dev@sha256:ea95ee7168f2d7728a649cc4a7c9cf7c403f903f6558a21b1c8cdca9946d7c29 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:ea95ee7168f2d7728a649cc4a7c9cf7c403f903f6558a21b1c8cdca9946d7c29

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
