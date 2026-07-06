FROM dhi.io/golang:1.26.4-debian13-dev@sha256:69c8fbc3f16f53e69cedebcf97a644b4e63e5ef778854ab366467271f2a2bef2 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:69c8fbc3f16f53e69cedebcf97a644b4e63e5ef778854ab366467271f2a2bef2

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
