FROM dhi.io/golang:1.26.5-debian13-dev@sha256:c1e3b4609107fb36e6b5edfc02f70fa39c161a81d88287ebde57dd0a803b2c06 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:c1e3b4609107fb36e6b5edfc02f70fa39c161a81d88287ebde57dd0a803b2c06

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
