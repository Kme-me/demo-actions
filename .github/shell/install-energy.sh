#!/usr/bin/env bash

cd /app

git clone https://github.com/energye/energy.git
cd energy/cmd/energy
go build -ldflags="-s -w" -o /app/go/bin/
energy cli -v

