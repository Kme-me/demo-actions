# ENERGY GUI demo-actions

## 介绍
这个仓库是使用 energy 框架开发的一个简单的示例软件，主要目的演示给不同的操作系统制作软件安装包过程

因 CGO 开启后，在不同系统架构交叉编译有的很麻烦。当然 MacOS 交叉 Windows 和 Linux 还是很方便的

`energy cli` 还不支持跨平台安装包制作， 正常来说，都应该在目标平台编译程序，你不得测试吗？

没时间去写独立的`工作流仓库`，有`工作流仓库`使用起来要比现在的更方便。以后在说吧

## 编译 & 安装包

使用 Github Actions 制作不同操作系统和架构的安装包

### 前提条件
 1. 需要你对 Github Actions 有些了解, `.yml` 使用
 2. 想使用 Github Actions 就必须在 Github 创建你自己仓库, 可以是私有仓库但有些限制

### 开始

- 需要你认真去看

- 照葫芦画瓢

- 主要东西都在 `demo-actions` 仓库的 `.github` 目录

#### 工作流 [workflows](.github%2Fworkflows)

`.yml`结构和定义不说了，自己去了解

分成了四个工作流文件. 方便阅读

- windows: [energy-build-package_windows.yml](.github%2Fworkflows%2Fenergy-build-package_windows.yml)

- macos: [energy-build-package_macos.yml](.github%2Fworkflows%2Fenergy-build-package_macos.yml)

- linux+arm64: [energy-build-package_linux.yml](.github%2Fworkflows%2Fenergy-build-package_linux.yml)

- linuxarmv7l: [energy-build-package_linuxarm.yml](.github%2Fworkflows%2Fenergy-build-package_linuxarm.yml)


#### 脚本 [shell](.github%2Fshell) 

给 linux 使用

linux在`docker`构建相对来说写的比较多


