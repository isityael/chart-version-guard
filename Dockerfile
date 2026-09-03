FROM dhi.io/golang:1.27.1-debian13-dev@sha256:aba199ecba031bbf5b35d9b4ccc4111123dc5b0ab4a3a41644299b6882c3de53 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.1-debian13-dev@sha256:aba199ecba031bbf5b35d9b4ccc4111123dc5b0ab4a3a41644299b6882c3de53

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
