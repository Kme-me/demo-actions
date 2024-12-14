#!/usr/bin/env bash

# 当前支持的最新CEF版本, 手动配置更新z
LatestVer="130.1.16"

CEF_VER=$1 # 101.0.18
ENG_VER=$2 # 2.5.0
UseGTK3=$3 # "" 或 gtk3

ARCH=$(dpkg --print-architecture)
LibLCLFilename="liblcl" # 完整 liblclxxx.zip
LibLCLOSAndARCH="" #
CEFFilename="" # 完整 CEFxxx.7z
LibLCLVer=${CEF_VER%%.*} # 101

if [ "$ARCH" = "armhf" ]; then
  LibLCLOSAndARCH="LinuxARM"
  CEFFilename="linuxarm"
fi
if [ "$ARCH" = "arm64" ]; then
  LibLCLOSAndARCH="LinuxARM64"
  CEFFilename="linuxarm64"
fi
if [ "$ARCH" = "amd64" ]; then
  LibLCLOSAndARCH="Linux64"
  CEFFilename="linux64"
fi
if [ "$ARCH" = "386" ]; then
  LibLCLOSAndARCH="Linux32"
  CEFFilename="linux32"
fi

if [ ! "$LatestVer" = "$CEF_VER" ]; then
  LibLCLFilename="liblcl-"$LibLCLVer
fi

if [ "$UseGTK3" = "gtk3" ]; then
  LibLCLFilename=$LibLCLFilename"-GTK3"
fi

get_value() {
    local key=$1
    grep "^$key=" "/app/shell/versionlist.txt" | cut -d'=' -f2
}

CEFFilename=$(get_value $CEF_VER_$CEFFilename)

cd /app

curl -L "https://sourceforge.net/projects/liblcl/files/CEF/$CEF_VER/$CEFFilename/download" -o "cef_binary.7z"

curl -L "https://sourceforge.net/projects/liblcl/files/v$ENG_VER/$LibLCLFilename.$LibLCLOSAndARCH.zip/download" -o "liblcl.zip"

7z x cef_binary.7z -o/app/EnergyFramework
7z x liblcl.zip -o/app/EnergyFramework
