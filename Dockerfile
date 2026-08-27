FROM dhi.io/golang:1.27.0-debian13-dev@sha256:983bb728c4ddb81d49b801ef8823231cc7ce98be1f3f6e0a8eb65fb403abbaba AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.0-debian13-dev@sha256:983bb728c4ddb81d49b801ef8823231cc7ce98be1f3f6e0a8eb65fb403abbaba

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
