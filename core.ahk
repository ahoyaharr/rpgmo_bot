#SingleInstance, force

#Include, lib\find_click.ahk
#Include, lib\console.ahk
#Include, lib\utils.ahk

#Include, core_captcha.ahk
#Include, core_combat.ahk
#Include, core_farming.ahk
#Include, core_interface.ahk
#Include, core_movement.ahk
#Include, core_ocr.ahk

SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Window
SetDefaultMouseSpeed, 0

global player_x := 426 ; The the window coordinate of the 
global player_y := 244 ; player character.

global win_x := 0 ; The upper left coordinates
global win_y := 0 ; of the game client

global hk_eat = r
global hk_deposit = e
global hk_withdraw = z
global hk_pet_load = c
global hk_pet_unload = q
global hk_toggle_bag = b
global hk_destroy_all = p

initialise() {
	Console.Alloc()
	Process, Exist, capture.exe
	if (ErrorLevel = 1) {
		Process,Close,capture.exe
		Console.Print("[INIT] capture.exe already running... stopping it`n")
	}
	Run %A_WorkingDir%\ocr\capture.exe --portable
	print("[INIT]: starting capture.exe...")
	Sleep, 2500
	window_name = RPG MO - Early Access
	print("[INIT]: searching for game client...")
	WinActivate, %window_name%
	WinWaitActive, %window_name%, , 30
	print("[INIT]: found game client focus...")
	WinGetPos win_x, win_y, , , %window_name%
	print("[INIT]: initialisation complete!")
}

main() {

}

#q::main()
#w::reload
#e::pause