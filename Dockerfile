FROM dhi.io/golang:1.26.5-debian13-dev@sha256:4f8306e798384952c56c754db2ef72f075413a73a0bcf512890fe43d58f315de AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:4f8306e798384952c56c754db2ef72f075413a73a0bcf512890fe43d58f315de

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
