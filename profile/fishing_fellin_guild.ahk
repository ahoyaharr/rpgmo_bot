main() {
	chest_to_fish := [new Portal(76, 32, 77, 32), new Coordinate(85, 28)]
	fish_to_chest := [new Portal(80, 26, 80, 25), new Coordinate(70, 26), new Coordinate(70, 30)]

	initialise()
	print("[ALERT]: Routine loaded. 63-73 steel harpoon fishing at Fellin Outpost.")
	count := 1
	start_time := A_TickCount 

	; Start near Fellin Outpost
	move(70, 30) 

	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))

		; Move to chest 
		
		open_chest(north)
		deposit_all()

		walk_path(chest_to_fish)
		harvest(east, count, formatted_time(start_time, A_TickCount))
		walk_path(fish_to_chest)

		count := count + 1
	}
}