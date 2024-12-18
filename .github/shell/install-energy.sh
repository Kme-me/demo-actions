#!/usr/bin/env bash

echo "Install ENERGY CLI"

cd /app

git clone https://github.com/energye/energy.git
cd energy/cmd/energy
go install
energy cli -v

