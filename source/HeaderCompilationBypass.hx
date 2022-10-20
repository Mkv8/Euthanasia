// CLASS USED TO BYPASS HEADER COMPILATION SHIT! (cause hxcpp is dumb)
import WindowsAPI.MessageBoxIcon;
class HeaderCompilationBypass {
	public static function setWindowToDarkMode() {
		WindowsAPI.setWindowToDarkMode();
	}
	public static function showMessagePopup(title:String, text:String, icon:MessageBoxIcon) {
		WindowsAPI.showMessagePopup(title, text, icon);
	}
	public static function setWindowTransparency(alpha:Int) {
		WindowsAPI.setWindowTransparency(alpha);
	}
}