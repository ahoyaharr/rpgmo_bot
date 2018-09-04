main() {
	initialise()
	print("[ALERT]: Routine loaded. Smithing at Dorpat.")
	count := 1
	start_time := A_TickCount 

	bar = iron_bar
	item = iron_pants

	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))

		; Move to chest 
		move(22, 18) 
		open_chest(south)
		deposit_all()
		if (!withdraw(bar)) {
			print("[ALERT] Finished Smithing!")
			Pause, On
		}
		close_chest()
		
		; Move to fire 
		move(25, 20)
		open_bag(true)
		open_forge(east)

		ImageSearch, x, y, 445, 186, 665, 278, %A_WorkingDir%\img\items\%item%.png
		if (!ErrorLevel) {
			click, %x%, %y%
			loop {
				sleep, 500
				Click, 333, 379 Left, 1
				hazard_check()
			} until (!has_item(bar))
		}
		Click, 647, 167 Left, 1

		count := count + 1
	}
}