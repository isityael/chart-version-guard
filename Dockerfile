FROM dhi.io/golang:1.26.5-debian13-dev@sha256:ae1f6a80aec9e82d8431115d9148f4c8e932efe04d706a51a30a5c0609a72ab9 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.5-debian13-dev@sha256:ae1f6a80aec9e82d8431115d9148f4c8e932efe04d706a51a30a5c0609a72ab9

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
