FROM dhi.io/golang:1.27.1-debian13-dev@sha256:baa8e6b0fe23dcfdcaec24af47e091660ba539685fe8340d0f5172227afadaf8 AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/chart-version-guard ./cmd/chart-version-guard

FROM dhi.io/golang:1.27.1-debian13-dev@sha256:baa8e6b0fe23dcfdcaec24af47e091660ba539685fe8340d0f5172227afadaf8

COPY --from=build /out/chart-version-guard /usr/local/bin/chart-version-guard
