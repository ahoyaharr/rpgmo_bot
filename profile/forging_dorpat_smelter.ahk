main() {
	initialise()
	print("[ALERT]: Routine loaded. Smelting at Dorpat.")
	count := 1
	start_time := A_TickCount 

	ore = iron_ore

	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))

		; Move to chest 
		move(22, 18) 
		open_chest(south)
		deposit_all()

		candidate_ores := StrSplit(ore, ",")
		selected_ore := ""
		Loop % candidate_ores.MaxIndex() {
		    selected_ore := candidate_ores[a_index]
			if (withdraw(selected_ore)) {
				load_pet_inventory()
				withdraw(selected_ore)
				break
			}
			selected_ore := ""
		}

		if (selected_ore == "") {
			print("[ALERT] Finished smelting!")
			Pause, On
		}
		close_chest()
		
		; Move to fire 
		move(22, 23)
		process(north, selected_ore)
		unload_pet_inventory()
		process(north, selected_ore)

		count := count + 1
	}
}