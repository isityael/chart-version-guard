FROM dhi.io/golang:1.27.0-debian13-dev@sha256:1a8387e5d698c4aa67f2c21669838be6009ecef1c26896bcbbcea96046c7dad1 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.0-debian13-dev@sha256:1a8387e5d698c4aa67f2c21669838be6009ecef1c26896bcbbcea96046c7dad1

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
