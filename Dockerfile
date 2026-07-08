FROM dhi.io/golang:1.26.5-debian13-dev@sha256:a19f8e2ecbd750863e1c84533ff37be18a0c41fab91c9260abb311e4335bdb46 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:a19f8e2ecbd750863e1c84533ff37be18a0c41fab91c9260abb311e4335bdb46

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
