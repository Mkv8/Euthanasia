package api;

#if windows
@:cppFileCode('
#include <windows.h>
#include <dwmapi.h>

#pragma comment(lib, "Dwmapi")
')
@:unreflective
@:nativeGen
#end
class Transparency {
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

	/*#if windows
	@:functionCode('
		if (!transparencyEnabled) return false;
		
		HWND window = GetActiveWindow();
		SetWindowLong(window, GWL_EXSTYLE, GetWindowLong(window, GWL_EXSTYLE) ^ WS_EX_LAYERED);
		SetLayeredWindowAttributes(window, 0, 255, LWA_ALPHA);
		transparencyEnabled = false;
	')
	#end
	public static function disableWindowTransparency(result:Bool = true) {
		return result;
	}*/
}