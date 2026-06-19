FROM dhi.io/golang:1.26.4-debian13-dev@sha256:fe1427449bb616840a52232ac8b0ecccca5cb14572dc66ba9dee50bb0198d121 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:fe1427449bb616840a52232ac8b0ecccca5cb14572dc66ba9dee50bb0198d121

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
