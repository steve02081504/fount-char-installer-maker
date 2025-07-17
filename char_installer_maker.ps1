#_require ps12exe
#_pragma Console 0
$char_url = Read-Host -Prompt "输入你的角色地址（传统酒馆角色的png的下载地址或risu的charx角色下载地址或fount角色的安装包下载地址或fount角色的git地址）"
$fount_url = "fount://run/shells/install/install;$([uri]::EscapeDataString($char_url))"
@"
if (!(get-command "fount" -ErrorAction SilentlyContinue)) {
	# prompt for choice
	`$result = `$Host.UI.PromptForChoice(
		"未检测到fount",
		"下载fount？",
		@("是","否"),
		0
	)
	if (`$result -eq 0) {
		`$scriptContent = Invoke-RestMethod https://raw.githubusercontent.com/steve02081504/fount/refs/heads/master/src/runner/main.ps1
		Invoke-Expression "function fountInstaller { `$scriptContent }"
		fountInstaller open protocolhandle "$fount_url"
	}
}
else {
	fount open protocolhandle "$fount_url"
}
"@ | ps12exe *>&1 | Out-Null
"编译成功！"
