buy(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Farming.")
	item = wheat_seed
	item_path = %A_WorkingDir%\img\items\%item%.png
	iteration := 1

	Loop {
		print("[STATUS] Buying " . item . ". Iteration " . iteration)

		move(22, 18)
		open_chest(south)
		deposit_all()
		move(31, 21)
		move_east(1)

		CoordMode, Pixel, Window
		ImageSearch, x, y, 256, 151, 622, 381, C:\Users\a\AppData\Roaming\MacroCreator\Screenshots\Screen_20180609135150.png
		If (!ErrorLevel) {
			click, %x%, %y%
			sleep, 250
			Loop, 40 {
				Click, 287, 390 Left, 1
				hazard_check()
			}

			load_pet_inventory()

			Loop, 20 {
				Click, 287, 390 Left, 1
				hazard_check()
			}		
		}


		iteration := iteration + 1
	}
}