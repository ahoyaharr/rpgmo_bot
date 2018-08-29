main() {
	initialise()
	print("[ALERT]: Routine loaded. Cutting spirits at Walco.")
	count := 1
	start_time := A_TickCount

	path := [new Coordinate(24, 30), new Coordinate(32, 33), new Coordinate(33, 36)
			,new Coordinate(37, 32), new Coordinate(42, 32), new Coordinate(43, 33)
			,new Coordinate(45, 32), new Coordinate(49, 32), new Coordinate(58, 34)]

	return_path := [new Coordinate(49, 32), new Coordinate(45, 32), new Coordinate(45, 33)
				   ,new Coordinate(42, 33), new Coordinate(42, 32), new Coordinate(37, 32)
				   ,new Coordinate(33, 36), new Coordinate(32, 33), new Coordinate(24, 30)]

	move(24, 30) 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))
		; Move to chest 
		open_chest(south)
		deposit_all()

		walk_path(path)
		harvest(south, count, formatted_time(start_time, A_TickCount))
		walk_path(return_path)
		count := count + 1
	}
}