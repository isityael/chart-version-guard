FROM dhi.io/golang:1.26.6-debian13-dev@sha256:b511696c1fb6929510c24d8ce66b90e7f9fc763082e5a8f73f778d7a177df93c AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.6-debian13-dev@sha256:b511696c1fb6929510c24d8ce66b90e7f9fc763082e5a8f73f778d7a177df93c

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
