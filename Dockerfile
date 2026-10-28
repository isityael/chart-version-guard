FROM dhi.io/golang:1.27.3-debian13-dev AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.3-debian13-dev

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
