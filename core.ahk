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
	print("[ALERT]: Routine loaded. Farming shrooms in the Lost Woods.")

	food = cooked_lion_fish
	teleport = whiland_teleport
	world := 0

	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest.
		move(29, 92) 

		; Store items and heal up.
		open_chest(east)
		deposit_all()
		withdraw(food)
		eat()
		deposit_all()
		withdraw(teleport)

		; Jump to correct world 
		Sleep, 5000
		send_command("world", mod(world++, 2) + 1)
		Loop {
			Sleep, 500
		} Until (!main_menu_is_open())

		; Move to Lost Woods
		move(20, 87)
		move(12, 91)
		move(9, 90)
		move_west(1)
		sleep, 1000

		; Now in Lost Woods
		move(83, 24)

		move(87, 30)
		attempt_combat(1, north) ; Grizzly

		move(86, 36)
		attempt_combat(1, north) ; Grizzly

		move(77, 39)
		move(71, 36)
		attempt_combat(1, west) ; Golden shroom

		move(77, 27)
		attempt_combat(1, south) ; Golden shroom

		move(75, 21)
		attempt_combat(1, south) ; Golden shroom

		move(69, 14)
		attempt_combat(1, south) ; Golden shroom

		move(65, 20)
		attempt_combat(1, north) ; Glowing shroom

		move(58, 19)
		attempt_combat(1, east) ; Golden shroom

		move(53, 24)
		attempt_combat(1, north) ; Glowing shroom

		move(50, 28)
		attempt_combat(1, north) ; Glowing shroom

		move(49, 23)
		attempt_combat(1, east) ; Golden shroom

		move(43, 27)
		attempt_combat(1, north) ; Glowing shroom

		move(44, 21)
		attempt_combat(1, north) ; Golden shroom

		move(45, 15)
		attempt_combat(1, south) ; Golden shroom

		move(54, 13)
		attempt_combat(1, east) ; Golden shroom

		move(45, 15)
		move(38, 21)
		attempt_combat(1, west) ; Glowing shroom 

		move(29, 23)
		attempt_combat(1, north) ; Glowing shroom

		move(27, 16)
		attempt_combat(1, north) ; Glowing shroom 

		move(24, 14)
		attempt_combat(1, north) ; Golden shroom 

		move(19, 12)
		attempt_combat(1, east) ; Glowing shroom

		move(14, 15)
		attempt_combat(1, south) ; Golden shroom

		move(16, 20)
		attempt_combat(1, north) ; Glowing shroom 

		move(16, 27)
		attempt_combat(1, west) ; Glowing shroom 

		move(15, 33)
		attempt_combat(1, west) ; Golden shroom 

		move(15, 44)
		move(15, 49)
		attempt_combat(1, north) ; Glowing shroom

		move(22, 50)
		attempt_combat(1, south) ; Glowing shroom 

		move(23, 58)
		attempt_combat(1, east) ; Golden shroom 

		move(15, 59)
		attempt_combat(1, west) ; Golden shroom 

		move(15, 65)
		attempt_combat(1, north) ; Golden shroom 

		move(20, 64)
		attempt_combat(1, east) ; Golden shroom

		load_pet_inventory()

		;; Jump to correct world
		Sleep, 5000
		send_command("world", mod(world++, 2) + 1)
		
		Loop {
			Sleep, 500
		} Until (!main_menu_is_open())
		Sleep, 2500

		load_pet_inventory()

		move(20, 64)
		attempt_combat(1, east) ; Golden shroom

		move(15, 65)
		attempt_combat(1, north) ; Golden shroom 

		move(15, 59)
		attempt_combat(1, west) ; Golden shroom

		move(23, 58)
		attempt_combat(1, east) ; Golden shroom

		move(22, 50)
		attempt_combat(1, south) ; Glowing shroom

		move(15, 49)
		attempt_combat(1, north) ; Glowing shroom

		move(15, 44)
 		move(15, 33)
		attempt_combat(1, west) ; Golden shroom 

		move(16, 27)
		attempt_combat(1, west) ; Glowing shroom 

		move(16, 22)
		attempt_combat(1, south) ; Glowing shroom 

		move(14, 15)
		attempt_combat(1, south) ; Golden shroom

		move(19, 12)
		attempt_combat(1, east) ; Glowing shroom

		move(24, 14)
		attempt_combat(1, north) ; Golden shroom 

		move(27, 16)
		attempt_combat(1, north) ; Glowing shroom

		move(29, 23)
		attempt_combat(1, north) ; Glowing shroom

		move(38, 21)
		attempt_combat(1, west) ; Glowing shroom 
		move(45, 15)

		move(54, 13)
		attempt_combat(1, east) ; Golden shroom

		move(45, 15)
		attempt_combat(1, south) ; Golden shroom

		move(44, 21)
		attempt_combat(1, north) ; Golden shroom

		move(43, 27)
		attempt_combat(1, north) ; Glowing shroom

		move(49, 23)
		attempt_combat(1, east) ; Golden shroom

		move(50, 28)
		attempt_combat(1, north) ; Glowing shroom

		move(53, 24)
		attempt_combat(1, north) ; Glowing shroom

		move(58, 19)
		attempt_combat(1, east) ; Golden shroom

		move(65, 20)
		attempt_combat(1, north) ; Glowing shroom

		move(69, 14)
		attempt_combat(1, south) ; Golden shroom

		move(75, 21)
		attempt_combat(1, south) ; Golden shroom

		move(77, 27)
		attempt_combat(1, south) ; Golden shroom

		move(73, 31)
		move(71, 36)
		attempt_combat(1, west) ; Golden shroom

		Loop {
			use_item(teleport)
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 28) <= 4 and abs(curr_pos[2] - 93) <= 5)

		count := count + 1
	}
}


pick() {
; Harvesting loop 
	Loop, 5 {
		current_offset := 3 * (A_Index - 1) ; Gives the positional offset 
		; Planting loop. Iter1 = rake, Iter2 = seed.
		move(11 + current_offset, 10)
		move(11 + current_offset, 17)
		reset_queue() ; Clears the queue and enters queue population mode 
		Loop, 16 { ; Populating queue
			print("adding relative (1" . ", " . A_Index . ")")
			relative_click(1, A_Index - 8) ; Click up row
		}
		Loop, 16 {
			print("adding relative (-1" . ", " . A_Index . ")")
			relative_click(-1, 9 - A_Index) ; Click down row
		}
		execute_queue()

		current_x := 11 + current_offset

		move(current_x, 10)

		while (current_x > 11) {
			current_x := current x - 3
			move(current_x, 9)
		}

		move(11, 10)
		open_chest(east)
		deposit_all()
		Sleep, 500
		close_chest()
		Sleep, 500
	}
}

#q::main("hello")
#w::reload
#e::pause
#r::FindClick()
#t::hazard_check()
#p::Console.Alloc()

#z::get_coordinate()
#m::pick()
#n::close_chest()