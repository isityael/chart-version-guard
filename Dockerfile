FROM dhi.io/golang:1.27.1-debian13-dev@sha256:b2c53244752dcb35fea192b1e7015635696c8456130e5b82bb0306f89e1144eb AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.1-debian13-dev@sha256:b2c53244752dcb35fea192b1e7015635696c8456130e5b82bb0306f89e1144eb

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
