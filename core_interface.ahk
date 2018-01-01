#Include, lib\find_click.ahk
#Include, lib\console.ahk

#Include, core_captcha.ahk

chest_is_open() {
	ImageSearch, FoundX, FoundY, 248, 117, 317, 154, %A_WorkingDir%\img\interface\chest.png
	if (ErrorLevel) {
		print("chest is closed")
		return False
	} else {
		print("chest is open")
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
			Click, 606, 135 Left, 1
			Sleep, 100
		} Until (!chest_is_open())
	}
	print("[SUCCESS]: Chest closed")
}

withdraw(item) {
	print("[TASK]: Withdraw " . item, 1)
	p = %A_WorkingDir%\img\items\%item%.png
	c = "r""RPG MO - Early Access"" k{Click}{z}"
	r := FindClick(p, c)
	CoordMode, Pixel, Window
	CoordMode, Mouse, Window
	if (r = "") {
		print("[WARNING]: Could not withdraw " . item, 1)
	} else {
		print("[SUCCESS]: Withdrew " . item, 1)
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
	toggle_bag()
	Loop {
		hazard_check()
		%direction%(1)
		;hazard_check()
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
	toggle_bag()
	cancel_action()
	print("[SUCCESS]: Resources harvested")
}

use_item(item) {
	print("[TASK]: Use " . item)
	toggle_bag()
	ImageSearch, FoundX, FoundY, 565, 80, 858, 282, %A_WorkingDir%\img\items\%item%.png
	if (!ErrorLevel) {
		Click, %FoundX%, %FoundY%
		print("[SUCCESS]: Used " . item)
		Sleep, 250
	} else {
		print("[FAILURE]: " . item . " not found!")
	}
	hazard_check()
	toggle_bag()
}

is_potted(potion) {
	ImageSearch, FoundX, FoundY, 89, 87, 173, 172, %A_WorkingDir%\img\items\%potion%.png
	return ErrorLevel
}

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

}