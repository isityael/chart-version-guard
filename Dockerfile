FROM dhi.io/golang:1.26.4-debian13-dev@sha256:b3713b0434df5180190c07cdec84effbbdafccb0d5e126533bf806202664eda3 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:b3713b0434df5180190c07cdec84effbbdafccb0d5e126533bf806202664eda3

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
