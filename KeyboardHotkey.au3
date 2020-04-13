#include <MsgBoxConstants.au3>
#include <ComboConstants.au3>
#include <Misc.au3>
#include <InetConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <Constants.au3>

Global $Pathdata = @ScriptDir & '\data.ini'
Global $key_HotNew[4]

;Khởi tạo bàn phím ảo
Func FormBoardSelect($Title = 'Key 1', $ButtonKey = '', $IDKEY = '',$HWND='')
	Dim $hotkey[83]
	Dim $key_new[83][2] = [ _
			['Esc', '1B'], ['F1', '70'], ['F2', '71'], ['F3', '72'], ['F4', '73'], ['F5', '74'], ['F6', '75'], ['F7', '76'], ['F8', '77'], _
			['F9', '78'], ['F10', '79'], ['F11', '7A'], ['F12', '7B'], ["`", 'C0'], ['1', '31'], ['2', '32'], ['3', '33'], ['4', '34'], ['5', '35'], _
			['6', '36'], ['7', '37'], ['8', '38'], ['9', '39'], ['0', '30'], ['-', 'BD'], ['=', 'BB'], ['', ''], ['Tab', '09'], ['Q', '51'], ['W', '57'], ['E', '45'], _
			['R', '52'], ['T', '54'], ['Y', '59'], ['U', '55'], ['I', '49'], ['O', '4F'], ['P', '50'], ['[', 'DB'], [']', 'DD'], ['\', 'DC'], ['Caps', '14'], ['A', '41'], _
			['S', '53'], ['D', '44'], ['F', '46'], ['G', '47'], ['H', '48'], ['J', '4A'], ['K', '4B'], ['L', '4C'], [';', 'BA'], ["'", ''], ['Enter', '0D'], ['Shift L', 'A0'], _
			['Z', '5A'], ['X', '58'], ['C', '43'], ['V', '56'], ['B', '42'], ['N', '4E'], ['M', '4D'], [',', 'BC'], ['.', 'BE'], ['/', 'BF'], ['Shift R', '10'], ['Ctrl L', '11'], _
			['WIN', '24'], ['Alt L', '12'], ['Space', ''], ['Alt R', '12'], ['Ctrl R', '11'], ['0', '60'], ['1', '61'], ['2', '62'], _
			['3', '63'], ['4', '64'], ['5', '65'], ['6', '66'], ['7', '67'], ['8', '68'], ['9', '69']]
			$GET_NOW_Tool = WinGetPos($HWND)
	$FormBoardSelect = GUICreate("Keyboard select " & $Title, 581, 161, $GET_NOW_Tool[0]-120, $GET_NOW_Tool[1]+$GET_NOW_Tool[3], -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))

	$hotkey[0] = GUICtrlCreateButton($key_new[0][0], 8, 8, 35, 25)
	For $xbut = 1 To 12
		$hotkey[$xbut] = GUICtrlCreateButton($key_new[$xbut][0], 47 + 35 * ($xbut - 1), 8, 35, 25)
	Next
	For $xbut = 13 To 25
		$hotkey[$xbut] = GUICtrlCreateButton($key_new[$xbut][0], 8 + 32 * ($xbut - 13), 32, 30, 25)
	Next
	$hotkey[26] = GUICtrlCreateButton($key_new[26][0], 8 + 32 * 13, 32, 40, 25)
	$hotkey[27] = GUICtrlCreateButton($key_new[27][0], 8, 56, 38, 25)
	For $xbut = 28 To 40
		$hotkey[$xbut] = GUICtrlCreateButton($key_new[$xbut][0], 15 + 32 * ($xbut - 27), 56, 30, 25)
	Next
	$hotkey[41] = GUICtrlCreateButton($key_new[41][0], 8, 80, 46, 25)
	For $xbut = 42 To 52
		$hotkey[$xbut] = GUICtrlCreateButton($key_new[$xbut][0], 56 + 32 * ($xbut - 42), 80, 30, 25)
	Next
	$hotkey[53] = GUICtrlCreateButton($key_new[53][0], 408, 80, 59, 25)
	$hotkey[54] = GUICtrlCreateButton($key_new[54][0], 8, 104, 70, 25)
	For $xbut = 55 To 64
		$hotkey[$xbut] = GUICtrlCreateButton($key_new[$xbut][0], 80 + 32 * ($xbut - 55), 104, 30, 25)
	Next
	$hotkey[65] = GUICtrlCreateButton($key_new[65][0], 400, 104, 67, 25)
	$hotkey[66] = GUICtrlCreateButton($key_new[66][0], 8, 128, 50, 25)
	$hotkey[67] = GUICtrlCreateButton($key_new[67][0], 64, 128, 40, 25)
	$hotkey[68] = GUICtrlCreateButton($key_new[68][0], 104, 128, 40, 25)
	$hotkey[69] = GUICtrlCreateButton($key_new[69][0], 144, 128, 230, 25)
	$hotkey[70] = GUICtrlCreateButton($key_new[70][0], 376, 128, 40, 25)
	$hotkey[71] = GUICtrlCreateButton($key_new[71][0], 416, 128, 50, 25)
	$hotkey[72] = GUICtrlCreateButton($key_new[72][0], 480, 104, 94, 25)
	$hotkey[73] = GUICtrlCreateButton($key_new[73][0], 480, 72, 30, 25)
	$hotkey[74] = GUICtrlCreateButton($key_new[74][0], 512, 72, 30, 25)
	$hotkey[75] = GUICtrlCreateButton($key_new[75][0], 544, 72, 30, 25)
	$hotkey[76] = GUICtrlCreateButton($key_new[76][0], 480, 40, 30, 25)
	$hotkey[77] = GUICtrlCreateButton($key_new[77][0], 512, 40, 30, 25)
	$hotkey[78] = GUICtrlCreateButton($key_new[78][0], 544, 40, 30, 25)
	$hotkey[79] = GUICtrlCreateButton($key_new[79][0], 480, 8, 30, 25)
	$hotkey[80] = GUICtrlCreateButton($key_new[80][0], 512, 8, 30, 25)
	$hotkey[81] = GUICtrlCreateButton($key_new[81][0], 544, 8, 30, 25)
	GUISetState(@SW_SHOW)

	Local $offnow
	While 1
		$nMsgs = GUIGetMsg()
		Switch $nMsgs
			Case $GUI_EVENT_CLOSE
				GUIDelete($FormBoardSelect)
				ExitLoop
			Case $hotkey[72] To $hotkey[81]
				For $xb = 72 To 81
					If $nMsgs = $hotkey[$xb] Then
						For $ixa = 0 To 3
							If $key_HotNew[$ixa] = $key_new[$xb][1] Then
								MsgBox(16, "Error", "Hotkey has been used", 5, $FormBoardSelect)
								ExitLoop
							EndIf
						Next
						If $ixa >= 4 Then $offnow = True
					EndIf
					If $offnow Then
						$key_HotNew[$IDKEY] = $key_new[$xb][1]
						GUICtrlSetData($ButtonKey, 'NUMPAD' & $key_new[$xb][0])
						GUIDelete($FormBoardSelect)
						IniWrite($Pathdata, "Hotkey", $IDKEY, $key_new[$xb][0] & '|' & $key_new[$xb][1])
						ExitLoop
					EndIf
				Next
			Case $hotkey[0] To $hotkey[71]
				For $xb = 0 To 71
					If $nMsgs = $hotkey[$xb] Then
						For $ixa = 0 To 3
							If $key_HotNew[$ixa] = $key_new[$xb][1] Then
								MsgBox(16, "Error", "Hotkey has been used", 5, $FormBoardSelect)
								$offnow = False
								ExitLoop
							EndIf
						Next
						If $ixa >= 4 Then $offnow = True
					EndIf
					If $offnow Then
						$key_HotNew[$IDKEY] = $key_new[$xb][1]
						GUICtrlSetData($ButtonKey, $key_new[$xb][0])
						GUIDelete($FormBoardSelect)
						IniWrite($Pathdata, "Hotkey", $IDKEY, $key_new[$xb][0] & '|' & $key_new[$xb][1])
						ExitLoop
					EndIf
				Next
		EndSwitch
		If $offnow Then ExitLoop
	WEnd
EndFunc   ;==>FormBoardSelect
