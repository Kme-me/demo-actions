#!/usr/bin/env bash

cd /app

curl -L "https://sourceforge.net/projects/liblcl/files/CEF/101.0.18/cef_binary_101.0.18%2Bg367b4a0%2Bchromium-101.0.4951.67_linux32_minimal.7z/download" -o "cef_binary.7z"

curl -L "https://sourceforge.net/projects/liblcl/files/v2.5.0/liblcl-101.Linux32.zip/download" -o "liblcl.zip"

7z x cef_binary.7z -o/app/EnergyFramework
7z x liblcl.zip -o/app/EnergyFramework

#export ENERGY_HOME=/app/EnergyFramework