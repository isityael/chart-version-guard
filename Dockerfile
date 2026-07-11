FROM dhi.io/golang:1.26.5-debian13-dev@sha256:1ef1aef62b8577699adccac73b6970b3ff893df89fdf57bf2cd0ce3b523724d1 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:1ef1aef62b8577699adccac73b6970b3ff893df89fdf57bf2cd0ce3b523724d1

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
