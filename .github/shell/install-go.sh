#!/usr/bin/env bash

version=$1

cd /app
wget "https://golang.google.cn/dl/$version"
tar -C /app -xzf "$version"
go version