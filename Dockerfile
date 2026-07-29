FROM dhi.io/golang:1.26.5-debian13-dev@sha256:b54979b74ce81ac3ae6a0c7895179f58faabdc2100fe28897e273fc8660e03e4 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:b54979b74ce81ac3ae6a0c7895179f58faabdc2100fe28897e273fc8660e03e4

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
