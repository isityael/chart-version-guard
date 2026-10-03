FROM dhi.io/golang:1.27.1-debian13-dev@sha256:f8c4aa48a1c66bb538adf04156a25c09f143cacb74e3a0d0daa85ad712a833e9 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.1-debian13-dev@sha256:f8c4aa48a1c66bb538adf04156a25c09f143cacb74e3a0d0daa85ad712a833e9

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
