FROM dhi.io/golang:1.26.4-debian13-dev@sha256:d1295e34ae659bfd57c305d67ec5177c15694fb82f25d98aee76d0ae08ef8ad1 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:d1295e34ae659bfd57c305d67ec5177c15694fb82f25d98aee76d0ae08ef8ad1

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
