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
	print("[ALERT]: Routine loaded. Mining white gold at Rakblood.")
	bronze_golem = %A_WorkingDir%\img\monster\bronze_golem.png
	count := 1
	start_time := A_TickCount 
	Loop {
		use_potion := False
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))
		move(37, 65)
		open_chest(east)
		deposit_all()
		if (is_potted("potion_of_mining_superior") != 0) {
			use_potion := True
			print("[TASK]: Repotting", 1)
			withdraw_one("potion_of_mining_superior")
		}
		withdraw("rakblood_teleport")
		move(30, 71)
		move(25, 62)
		move(18, 55)
		move(15, 50)
		move_west(1)
		Loop {
		PixelSearch, FoundX, FoundY, 383, 194, 418, 243, bronze_golem, 0, Fast RGB
		If (ErrorLevel = 0) {
				print("[ALERT]: bronze_golem detected.")
				move_west(1)
				Sleep, 1000
				complete_combat(30)
			}
		} Until (ErrorLevel)
		move(13, 38)
		move(10, 30)
		move(7, 20)
		use_item("potion_of_mining_superior")
		harvest(west)
		Loop {
			use_item("rakblood_teleport")
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 34) <= 4 and abs(curr_pos[2] - 68) <= 5)
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