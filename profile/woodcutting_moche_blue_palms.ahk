main() {
	initialise()
	print("[ALERT]: Routine loaded. Cutting Blue Palms in the Woodcutting Guild.")

	chest_to_trees := [new Coordinate(48, 53), new Coordinate(52, 42), new Coordinate(60, 41)
					 , new Coordinate(67, 40), new Coordinate(79, 36), new Coordinate(79, 36)
					 , new Portal(85, 34, 85, 32), new Coordinate(85, 29)]

	trees_to_chest := [new Portal(84, 32, 85, 35), new Coordinate(74, 36), new Coordinate(65, 40)
					 , new Coordinate(56, 44), new Coordinate(47, 48), new Coordinate(51, 54)
					 , new Coordinate(53, 61)]

	count := 1
	start_time := A_TickCount 
	move(53, 61)
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))

		; Store items and heal up.
		open_chest(south)
		deposit_all()

		; Walk to guild
		walk_path(chest_to_trees)
		harvest(south)
		walk_path(trees_to_chest)

		count := count + 1
	}
}