FROM dhi.io/golang:1.27.1-debian13-dev@sha256:9b23f00c5b36018b72742352c391e78c200193eea59c81d7043a19193a1a6a4b AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.1-debian13-dev@sha256:9b23f00c5b36018b72742352c391e78c200193eea59c81d7043a19193a1a6a4b

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
