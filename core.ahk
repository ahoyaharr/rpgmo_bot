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
	window_name = RPG MO - Early Access
	print("[INIT]: searching for game client...")
	WinActivate, %window_name%
	WinWaitActive, %window_name%, , 30
	print("[INIT]: found game client focus...")
	WinGetPos win_x, win_y, , , %window_name%
	print("[INIT]: initialisation complete!")
}


main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Cutting maples at Reval.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(24, 30) 
		open_chest(south)
		deposit_all()

		; Move to tree 
		move(32, 33)
		move(33, 36)
		move(37, 32)
		move(43, 32)
		move(43, 34)
		move(44, 34)
		move(44, 36)
		move(49, 36)
		move(49, 33)
		move(55, 33)
		move(58, 34)
		harvest(south)

		; Return to chest
		move(55, 33)
		move(49, 33)
		move(49, 36)
		move(44, 36)
		move(44, 34)
		move(43, 34)
		move(43, 32)
		move(37, 32)
		move(33, 36)
		move(32, 33)

		count := count + 1
	}
}


#q::main("hello")
#w::reload
#e::pause
#r::FindClick()
#t::hazard_check()
#p::Console.Alloc()

#z::get_coordinate()

#m::open_chest(east)
#n::close_chest()