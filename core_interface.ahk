#Include, lib\find_click.ahk
#Include, lib\console.ahk

#Include, core_captcha.ahk

open_chest(direction) {
	print("[TASK]: Open chest")
	Loop { 
		%direction%(1)
		ImageSearch, FoundX, FoundY, 248, 117, 317, 154, %A_WorkingDir%\img\chest.png
	} 
	Until (ErrorLevel = 0)
	print("[SUCCESS]: Opened chest")
}

close_chest() {
	print("[TASK]: Close chest")
	Loop {
		Click, 606, 135 Left, 1
		Sleep, 100
		ImageSearch, FoundX, FoundY, 248, 117, 317, 154, %A_WorkingDir%\img\chest.png
	} Until (ErrorLevel != 0)
	print("[SUCCESS]: Chest closed")
}

withdraw(item) {
	print("[TASK]: Withdraw " . item, 1)
	p = %A_WorkingDir%\img\%item%.png
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
		captcha_check()
		%direction%(1)
		;captcha_check()
		Sleep, 5000
		ImageSearch, FoundX, FoundY, 817, 226, 859, 267, %A_WorkingDir%\img\inventory_box.png
		If (ErrorLevel) {
			load_pet_inventory()
			Sleep, 500
		}
		ImageSearch, FoundX, FoundY, 817, 226, 859, 267, %A_WorkingDir%\img\inventory_box.png
		main_inventory_full := ErrorLevel
		ImageSearch, FoundX, FoundY, 815, 341, 859, 382, %A_WorkingDir%\img\inventory_box.png
		pet_inventory_full := ErrorLevel
	} Until (main_inventory_full and pet_inventory_full)
	toggle_bag()
	cancel_action()
	print("[SUCCESS]: Resources harvested")
}

use_item(item) {
	print("[TASK]: Use " . item)
	toggle_bag()
	p = %A_WorkingDir%\img\%item%.png
	c = "r""RPG MO - Early Access"""
	FindClick(p, c)
	print("[SUCCESS]: Used " . item)
	CoordMode, Pixel, Window
	CoordMode, Mouse, Window
	captcha_check()
	toggle_bag()
}

toggle_bag() {
	send b
	Sleep, 250
}

load_pet_inventory() {
	sleep, 250
	send c
	Sleep, 250
}

unload_pet_inventory() {
	sleep, 250
	send q
	Sleep, 500
}

deposit_all() {
	send e
	Sleep, 500
	unload_pet_inventory()
	Sleep, 500
	send e
	Sleep, 500
}