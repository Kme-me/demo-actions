#!/usr/bin/env bash

# 当前支持的最新CEF版本, 手动配置更新z
LatestVer="130.1.16"
ARCH=$(dpkg --print-architecture)

echo "LatestVer: $LatestVer, ARCH: $ARCH"

CEF_VER=$1 # 格式: 101.0.18
ENG_VER=$2 # 格式: 2.5.0
UseGTK3=$3 # 格式: "" 或 gtk3
LibLCLVer=${CEF_VER%%.*} # 101

echo "Arguments CEF_VER: $CEF_VER, ENG_VER: $ENG_VER, UseGTK3: $UseGTK3, LibLCLVer: $LibLCLVer"


LibLCLFilename="liblcl" # 完整 liblclxxx.zip
LibLCLOSAndARCH="" #
CEFFilename="" # 完整 CEFxxx.7z

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
if [ "$ARCH" = "i386" ]; then
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

CEFFilename=$(get_value "$CEF_VER-$CEFFilename")

cd /app

rm -rf /app/cef_binary.7z
rm -rf /app/liblcl.zip
rm -rf /app/energy/$ENERGY_FRAMEWORK

echo "Download CEF and LibLCL, CEF: $CEF_VER/$CEFFilename, LibLCL: v$ENG_VER/$LibLCLFilename.$LibLCLOSAndARCH.zip"

CEFDownloadURL="https://sourceforge.net/projects/liblcl/files/CEF/$CEF_VER/$CEFFilename/download"
LibLCLDownloadURL="https://sourceforge.net/projects/liblcl/files/v$ENG_VER/$LibLCLFilename.$LibLCLOSAndARCH.zip/download"

echo "CEFDownloadURL: $CEFDownloadURL"
echo "LibLCLDownloadURL: $LibLCLDownloadURL"

curl -L $CEFDownloadURL -o "cef_binary.7z"

curl -L $LibLCLDownloadURL -o "liblcl.zip"

7z x cef_binary.7z -o/app/energy/$ENERGY_FRAMEWORK
7z x liblcl.zip -o/app/energy/$ENERGY_FRAMEWORK