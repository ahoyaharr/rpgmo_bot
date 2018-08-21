main(profile) {
	chest_to_fish := [new Coordinate(83, 37), new Coordinate(82, 45), new Coordinate(82, 56), 
					, new Coordinate(83, 68), new Coordinate(83, 78), new Coordinate(82, 88)]

	initialise()
	print("[ALERT]: Routine loaded. 63-73 steel harpoon fishing at Dorpat Outpost.")
	count := 1
	start_time := A_TickCount 

	; Start near Dorpat Outpost
	move(83, 37) 

	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		
		open_chest(north)
		deposit_all()

		walk_path(chest_to_fish)
		harvest(north)
		walk_path(chest_to_fish, tolerance:=0, reversed:=True)

		count := count + 1
	}
}