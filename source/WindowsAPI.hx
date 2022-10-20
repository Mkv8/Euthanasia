package;

#if windows
@:buildXml('
<compilerflag value="/DelayLoad:ComCtl32.dll"/>

<target id="haxe">
	<lib name="dwmapi.lib" if="windows" />
	<lib name="shell32.lib" if="windows" />
	<lib name="gdi32.lib" if="windows" />
</target>
')
@:headerCode('
#include <Windows.h>
#include <cstdio>
#include <iostream>
#include <tchar.h>
#include <dwmapi.h>
#include <winuser.h>
#include <Shlobj.h>
#include <wingdi.h>
#include <shellapi.h>
')
#end
class WindowsAPI {
	#if windows
	@:functionCode('
		int darkMode = 1;
		HWND window = GetActiveWindow();
		if (S_OK != DwmSetWindowAttribute(window, 19, &darkMode, sizeof(darkMode))) {
			DwmSetWindowAttribute(window, 20, &darkMode, sizeof(darkMode));
		}
		UpdateWindow(window);
	')
	#end
	public static function setWindowToDarkMode() {}

	#if windows
	@:functionCode('
		return MessageBox(GetActiveWindow(), text, title, icon | MB_SETFOREGROUND);
	')
	#end
	public static function showMessagePopup(title:String, text:String, icon:MessageBoxIcon):Int {
		lime.app.Application.current.window.alert(title, text);
		return 0;
	}

	#if windows
	@:functionCode('
		HWND window = GetActiveWindow();

		// make window layered
		int result = SetWindowLong(window, GWL_EXSTYLE, GetWindowLong(window, GWL_EXSTYLE) | WS_EX_LAYERED);
		SetLayeredWindowAttributes(window, 0, alpha, LWA_ALPHA);
		//return result;
	')
	#end
	public static function setWindowTransparency(alpha:Int) {
		//return 0;
	}
}

@:enum abstract MessageBoxIcon(Int) {
	var MSG_ERROR = 0x00000010;
	var MSG_QUESTION = 0x00000020;
	var MSG_WARNING = 0x00000030;
	var MSG_INFORMATION = 0x00000040;
}