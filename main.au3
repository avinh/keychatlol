#RequireAdmin

#include "KeyboardHotkey.au3"

Local $hDLL = DllOpen("user32.dll")
;tao tray icon click
Opt("TrayMenuMode", 1)
TraySetState()


;-------------------
Global Const $HK_CHAR = 0x102
Global Const $HK_KEYDOWN = 0x100
Global Const $HK_KEYUP = 0x101
Global Const $HK_RETURN = 0xD

Global $gameclass = "[CLASS:RiotWindowClass]"
Local $version = '1005'
Local $checkver = BinaryToString(InetRead('http://f2pauto.com/apps/KeyChatLOL/ver.dat', 1), 4)

;kiểm tra kết nối tới website và kiểm tra phiên bản
If $checkver = 0 Then
	MsgBox(16, 'Warning', "Error connect to server")
	Exit
ElseIf $version < $checkver Then
	$Dupdate = MsgBox(4, 'Message', "New update software")
	If $Dupdate = 6 Then
		ShellExecute("http://f2pauto.com/threads/4/")
		Exit
	Else
		Exit
	EndIf
EndIf

;Kiểm tra cửa sổ phần mềm đã mở
If WinExists("Key Chat LOL") Then
	MsgBox(48, 'Warning', "Application opened")
	Exit
EndIf

;Khởi tạo GUI

$Form = GUICreate("Key Chat LOL", 330, 222, -1, -1, BitXOR($GUI_SS_DEFAULT_GUI, $WS_MINIMIZEBOX))
$labelHotkey = GUICtrlCreateLabel("Key", 16, 8, 28, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
$LabelMessage = GUICtrlCreateLabel("Message", 96, 8, 59, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
$Input1 = GUICtrlCreateInput(IniRead($Pathdata, 'Textkey', 'Text1', ''), 96, 40, 217, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$Input2 = GUICtrlCreateInput(IniRead($Pathdata, 'Textkey', 'Text2', ''), 96, 72, 217, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$Input3 = GUICtrlCreateInput(IniRead($Pathdata, 'Textkey', 'Text3', ''), 96, 104, 217, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$Input4 = GUICtrlCreateInput(IniRead($Pathdata, 'Textkey', 'Text4', ''), 96, 136, 217, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$ButtonHide = GUICtrlCreateButton("Hide", 280, 184, 35, 25)
$ButtonHelp = GUICtrlCreateButton("?", 240, 184, 35, 25)
$ButtonSave = GUICtrlCreateButton("Save", 160, 184, 75, 25)
$ButtonKey1 = GUICtrlCreateButton("", 8, 40, 75, 25)
$ButtonKey2 = GUICtrlCreateButton("", 8, 72, 75, 25)
$ButtonKey3 = GUICtrlCreateButton("", 8, 104, 75, 25)
$ButtonKey4 = GUICtrlCreateButton("", 8, 136, 75, 25)
$labelLogo = GUICtrlCreateLabel("F2P Auto", 16, 192, 61, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
GUISetState(@SW_SHOW)

Local $load_Key[4]

For $keyload = 0 To 3
	$string_tach = StringSplit(IniRead($Pathdata, "Hotkey", $keyload, ""), '|')
	If Not @error Then
		$load_Key[$keyload] = $string_tach[1]
		$key_HotNew[$keyload] = $string_tach[2]
	EndIf
Next

GUICtrlSetData($ButtonKey1, $load_Key[0])
GUICtrlSetData($ButtonKey2, $load_Key[1])
GUICtrlSetData($ButtonKey3, $load_Key[2])
GUICtrlSetData($ButtonKey4, $load_Key[3])

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ButtonSave
			IniWrite($Pathdata, 'Textkey', 'Text1', GUICtrlRead($Input1))
			IniWrite($Pathdata, 'Textkey', 'Text2', GUICtrlRead($Input2))
			IniWrite($Pathdata, 'Textkey', 'Text3', GUICtrlRead($Input3))
			IniWrite($Pathdata, 'Textkey', 'Text4', GUICtrlRead($Input4))
			MsgBox(0, "Message", "Saved the messege")
		Case $ButtonHelp
			ShellExecute('http://f2pauto.com/threads/4/')
		Case $ButtonHide
			GUISetState(@SW_HIDE, $Form)
			TrayTip("", "Has hidden Key Chat LOL.", 5)
		Case $ButtonKey1
			FormBoardSelect("Key 1", $ButtonKey1, 0,$Form)
		Case $ButtonKey2
			FormBoardSelect("Key 2", $ButtonKey2, 1,$Form)
		Case $ButtonKey3
			FormBoardSelect("Key 3", $ButtonKey3, 2,$Form)
		Case $ButtonKey4
			FormBoardSelect("Key 4", $ButtonKey4, 3,$Form)
	EndSwitch

	;tray icon
	$msg = TrayGetMsg()
	Select
		Case $msg = $TRAY_EVENT_PRIMARYDOWN
			If GUISetState(@SW_SHOW, $Form) = 0 Then
				GUISetState(@SW_HIDE, $Form)
				TrayTip("", "A different tray tip.", 5)
			Else
				GUISetState(@SW_SHOW, $Form)
			EndIf
	EndSelect
	controlkey()
WEnd

;Hàm read hot key
Func controlkey()
	If gamecheck() Then
		If _IsPressed($key_HotNew[0], $hDLL) Then
		chat(GUICtrlRead($Input1))
	  EndIf

	  If _IsPressed($key_HotNew[1], $hDLL) Then
		chat(GUICtrlRead($Input2))
	  EndIf

	  If _IsPressed($key_HotNew[2], $hDLL) Then
		chat(GUICtrlRead($Input3))
	  EndIf

	  If _IsPressed($key_HotNew[3], $hDLL) Then
		 chat(GUICtrlRead($Input4))
	  EndIf
	Else
		Return
	EndIf
EndFunc   ;==>controlkey

;Bắt đầu nhận dạng cửa sổ game và truyền phím
Func chat($text)
	  global $hwnd = WinGetHandle('League of Legends (TM) Client')
		 PushKey('enter',$hwnd)
		 Sleep(15)
		 PushKey('backspace',$hwnd)
		 PushKey('backspace',$hwnd)
		 PushKey('backspace',$hwnd)
		 Sleep(15)
		 SendChar($text,$hwnd)
		 Sleep(15)
		 PushKey('enter',$hwnd)
		 Sleep(3000)
EndFunc

;Kiểm tra game có được mở không
Func gamecheck()
   If WinExists($gameclass) Then
	  Return 1
   Else
	  Return 0
   EndIf
EndFunc

;Hàm postmessage
Func PostMessage($Arg00, $Arg01, $Arg02, $Arg03)
   DllCall("user32.dll", "lresult", "PostMessageW", "hwnd", $Arg00, "uint", $Arg01, "wparam", $Arg02, "lparam", $Arg03)
EndFunc

;Hàm gửi kí tự
Func SendChar($text,$hwnd)
   For $j = 0 To StringLen($text)
	  PostMessage($hwnd,$HK_CHAR,AscW(StringMid($text,$j,1)),0)
   Next
EndFunc

;push phím enter và backspace
 Func PushKey($k,$lchwnd)
	Switch $k
	Case 'enter'
		$key = 0xD
	Case 'backspace'
		$key = 0x08
	Case Else
		$key = $hk_Return
	 EndSwitch
	PostMessage($lchwnd,$HK_KEYDOWN,$key,0x1C0001)
	PostMessage($lchwnd,$HK_KEYUP,$key,0x1C0001)
 EndFunc

