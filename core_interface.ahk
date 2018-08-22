#Include, lib\find_click.ahk
#Include, lib\console.ahk

#Include, core_captcha.ahk

chest_is_open() {
	ImageSearch, FoundX, FoundY, 248, 117, 317, 154, %A_WorkingDir%\img\interface\chest.png
	if (ErrorLevel) {
		print("[STATUS] Chest is closed", 1)
		return False
	} else {
		print("[STATUS] Chest is open", 1)
		return True
	}
}

open_chest(direction) {
	print("[TASK]: Open chest")
	Loop { 
		%direction%(1)
	} 
	Until (chest_is_open())
	print("[SUCCESS]: Opened chest")
}

close_chest() {
	if (chest_is_open()) {
		print("[TASK]: Close chest")
		Loop {
			Sleep, 1000
			Click, 606, 135 Left, 1
			Sleep, 1000
		} Until (!chest_is_open())
	}
	print("[SUCCESS]: Chest closed")
}

withdraw(item) {
	print("[TASK]: Withdraw " . item, 1)
	p = %A_WorkingDir%\img\items\%item%.png
	c = "r""RPG MO - Early Access"" k{Click}{z}"
	r := FindClick(p, c)
	sleep, 250
	CoordMode, Pixel, Window
	CoordMode, Mouse, Window
	if (r = "0") {
		print("[WARNING]: Could not withdraw " . item, 1)
		return False
	} else {
		print("[SUCCESS]: Withdrew " . item, 1)
		return True
	}
}

withdraw_one(item) {
	print("[TASK]: Withdraw " . item, 1)
	p = %A_WorkingDir%\img\items\%item%.png
	c = "r""RPG MO - Early Access"" k{Click}"
	r := FindClick(p, c)
	CoordMode, Pixel, Window
	CoordMode, Mouse, Window
	if (r = "") {
		print("[WARNING]: Could not withdraw " . item, 1)
	} else {
		Click, 330, 389 Left, 1
		print("[SUCCESS]: Withdrew " . item, 1)
	}
}

cancel_action() {
	Loop, 3 {
		Click, %player_x%, %player_y%, 1
		Sleep, 100
	}
}

harvest(direction) {
	print("[TASK]: Harvest resource")
	open_bag(True)
	Loop {
		hazard_check()
		%direction%(1)
		Sleep, 1000
		ImageSearch, FoundX, FoundY, 817, 226, 859, 267, %A_WorkingDir%\img\interface\inventory_box.png
		If (ErrorLevel) {
			load_pet_inventory()
		}
		ImageSearch, FoundX, FoundY, 817, 226, 859, 267, %A_WorkingDir%\img\interface\inventory_box.png
		main_inventory_full := ErrorLevel
		ImageSearch, FoundX, FoundY, 815, 341, 859, 382, %A_WorkingDir%\img\interface\inventory_box.png
		pet_inventory_full := ErrorLevel
	} Until (main_inventory_full and pet_inventory_full)
	open_bag(False)
	cancel_action()
	print("[SUCCESS]: Resources harvested")
}

process(direction, item) {
	print("[TASK]: Process " . item)
	open_bag(True)
	if (use_item(item)) {
		Loop {
			hazard_check()
			%direction%(1)
			Sleep, 1000
		} Until (!has_item(item))
	}
	open_bag(False)
}

has_item(item, toggle:=True) {
	; Toggle will restore the bag state after the fn completes
	bag_status := bag_is_open()
	open_bag(True)
	ImageSearch, FoundX, FoundY, 565, 80, 858, 282, %A_WorkingDir%\img\items\%item%.png
	result := !ErrorLevel ; Need to save to variable because open_bag will modify ErrorLevel
	if (toggle) {
		open_bag(bag_status)
	}	
	return result ; ErrorLevel is 0 when imageSearch is successful
}

use_item(item, toggle:=True) {
	; Toggle will restore the bag state after the fn completes
	success := False
	print("[TASK]: Use " . item)
	bag_status := bag_is_open()
	open_bag(True)
	ImageSearch, FoundX, FoundY, 565, 80, 858, 282, %A_WorkingDir%\img\items\%item%.png
	if (!ErrorLevel) {
		Click, %FoundX%, %FoundY%
		success := True
		print("[SUCCESS]: Used " . item)
	} else {
		print("[FAILURE]: " . item . " not found!")
	}
	Sleep, 250
	hazard_check()
	if (toggle) {
		open_bag(bag_status)
	}
	return success
}

bag_is_open() {
	ImageSearch, FoundX, FoundY, 844, 266, 859, 287, %A_WorkingDir%\img\interface\bag_is_open.png
	return !ErrorLevel
}

is_potted(potion) {
	ImageSearch, FoundX, FoundY, 89, 87, 173, 172, %A_WorkingDir%\img\items\%potion%.png
	return ErrorLevel
}

open_bag(action) {
	; Opens bag if action := True, otherwise closes the bag.
	while (bag_is_open() != action) {
		toggle_bag()
	}
}

; Do not use blind fns in public context
toggle_bag() {
	send b
	Sleep, 250
}

load_pet_inventory() {
	send c
	Sleep, 1000
}

unload_pet_inventory() {
	send q
	Sleep, 1000
}

deposit_all() {
	send e
	Sleep, 1000
	unload_pet_inventory()
	send e
	Sleep, 1000
}

destroy_all() {
	send, p
	Sleep, 1000
	Send, {enter}
	close_chat()
}

send_command(command, argument) {
	open_chat()
	full_command := "/" . command . " " . argument
	print("[ALERT] Sending command: '" . full_command . "'")
	Send, %full_command%
	Sleep, 250
	Send, {Enter}
}

chat_is_open() {
	CoordMode, Pixel, Window
	ImageSearch, FoundX, FoundY, 47, 467, 85, 486, %A_WorkingDir%\img\interface\chat_bar.png
	return !ErrorLevel
}	

close_chat() {
	if (chat_is_open()) {
		Loop {
			Send, {Enter}
			Sleep, 250
		} Until (!chat_is_open())
	}
	return !chat_is_open()
}

open_chat() {
	Loop {
		Send, {Enter}
		Sleep, 250
	} Until (chat_is_open())
}

main_menu_is_open() {
		CoordMode, Pixel, Window
		ImageSearch, FoundX, FoundY, 108, 381, 155, 438, %A_WorkingDir%\img\interface\main_menu.png
		return !ErrorLevel
}