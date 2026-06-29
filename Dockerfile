FROM dhi.io/golang:1.26.4-debian13-dev@sha256:dd625ea57c53fae1bd65b3c6c1406a607035b5883edbaf0409c29aed8026e5ed AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.26.4-debian13-dev@sha256:dd625ea57c53fae1bd65b3c6c1406a607035b5883edbaf0409c29aed8026e5ed

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
