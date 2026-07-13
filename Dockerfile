FROM dhi.io/golang:1.26.5-debian13-dev@sha256:9055e3d075abbf69407899d716ba000d5bf0767cafedb31a49278cb3eace18c9 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:9055e3d075abbf69407899d716ba000d5bf0767cafedb31a49278cb3eace18c9

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
