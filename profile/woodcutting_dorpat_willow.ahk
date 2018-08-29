main() {
	initialise()
	print("[ALERT]: Routine loaded. Cutting wilows at Dorpat.")
	count := 1
	start_time := A_TickCount 

	path := [new Coordinate(83, 37), new Coordinate(82, 47)
	       , new Coordinate(82, 58), new Coordinate(83, 69)
	       , new Coordinate(83, 79), new Coordinate(81, 86)]

	move(83, 37) 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))

		; Move to chest 
		
		open_chest(north)
		deposit_all()

		; Move to tree 
		walk_path(path)
		harvest(north, count, formatted_time(start_time, A_TickCount))
		walk_path(path, 0, True) ; Return 
		
		count := count + 1
	}
}