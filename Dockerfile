FROM dhi.io/golang:1.27.1-debian13-dev@sha256:ce4e3984089cc0429a487c42427c6c43331b5b4eac6a58d517afc2e7cb53dc08 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.1-debian13-dev@sha256:ce4e3984089cc0429a487c42427c6c43331b5b4eac6a58d517afc2e7cb53dc08

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
