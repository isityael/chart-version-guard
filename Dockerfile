FROM dhi.io/golang:1.26.7-debian13-dev@sha256:ff7c1ae3a8a313f76147a8d6299b20e49bcf5ee1cf0cfec84a8b1b3e66e589a9 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.7-debian13-dev@sha256:ff7c1ae3a8a313f76147a8d6299b20e49bcf5ee1cf0cfec84a8b1b3e66e589a9

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
