FROM dhi.io/golang:1.26.4-debian13-dev@sha256:0f37e90f823cf707cb60cf2740d69c4556adaf4e1c90938cc69cdbfd32f98fac AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:0f37e90f823cf707cb60cf2740d69c4556adaf4e1c90938cc69cdbfd32f98fac

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
