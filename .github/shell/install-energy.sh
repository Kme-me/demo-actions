#!/usr/bin/env bash

echo "Install ENERGY CLI"

cd /app

git clone https://github.com/energye/energy.git
go env -w GOFLAGS=-buildvcs=false
cd energy/cmd/energy
go build -ldflags="-s -w" -o /app/go/bin/
energy cli -v

