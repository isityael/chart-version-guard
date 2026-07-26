FROM dhi.io/golang:1.26.5-debian13-dev@sha256:c15c327d115e8af76f50fb5dc9da2d81280527ff6da30b5eb423499eb42c5897 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:c15c327d115e8af76f50fb5dc9da2d81280527ff6da30b5eb423499eb42c5897

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
