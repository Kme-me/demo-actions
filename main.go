package main

import (
	"embed"
	"fmt"
	"github.com/energye/energy/v2/cef"
	"github.com/energye/energy/v2/cef/ipc"
	"github.com/energye/energy/v2/cef/ipc/context"
	"github.com/energye/energy/v2/examples/common"
	"github.com/energye/energy/v2/examples/common/tray"
	_ "github.com/energye/energy/v2/examples/syso"
	"github.com/energye/energy/v2/pkgs/assetserve"
	"github.com/energye/golcl/lcl"
	"os"
	"path"
)

//go:embed resources
var resources embed.FS

func main() {
	cef.GlobalInit(nil, common.ResourcesFS())
	cefApp := cef.NewApplication()
	cefApp.SetUseMockKeyChain(true)

	wd, _ := os.Getwd()
	indexHtmlPath := path.Join(wd, "resources", "index.html")

	//指定一个URL地址，或本地html文件目录
	cef.BrowserWindow.Config.Url = indexHtmlPath
	cef.BrowserWindow.Config.IconFS = "resources/icon.ico"
	cef.BrowserWindow.Config.Title = "Energy 打印PFD预览"
	cef.SetBrowserProcessStartAfterCallback(func(b bool) {
		fmt.Println("主进程启动 创建一个内置http服务")
		//通过内置http服务加载资源
		server := assetserve.NewAssetsHttpServer()
		server.PORT = 22022
		server.AssetsFSName = "resources" //必须设置目录名
		server.Assets = &resources
		go server.StartHttpServer()
	})

	//监听事件
	ipc.On("print-pdf", func(context context.IContext) {
		bw := cef.BrowserWindow.GetWindowInfo(context.BrowserId())
		savePath := path.Join(wd, "example", "browser-print-pdf", "test.pdf")
		fmt.Println("当前页面保存为PDF", savePath)
		bw.Chromium().PrintToPDF(savePath)
	})
	cef.BrowserWindow.SetBrowserInit(func(event *cef.BrowserEvent, window cef.IBrowserWindow) {
		if window.IsLCL() {
			tray.LCLTray(window)
		}
		window.Chromium().SetOnPdfPrintFinished(func(sender lcl.IObject, ok bool) {
			fmt.Println("OnPdfPrintFinished:", ok)
		})
	})

	cef.Run(cefApp)
}
