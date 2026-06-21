FROM dhi.io/golang:1.26.4-debian13-dev@sha256:c02293a491c454b4fa27653b9d1ff8991b7355ce7b71a9ff6bc6b827e3eb9379 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:c02293a491c454b4fa27653b9d1ff8991b7355ce7b71a9ff6bc6b827e3eb9379

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
