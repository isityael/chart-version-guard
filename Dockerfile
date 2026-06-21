FROM dhi.io/golang:1.26.4-debian13-dev@sha256:9b3c0c54676da09f259885a5d9b0546a222698b6db7fc415e06867529b5e391e AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:9b3c0c54676da09f259885a5d9b0546a222698b6db7fc415e06867529b5e391e

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
