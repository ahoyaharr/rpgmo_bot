main() {
	enable_potion_use := False
	initialise()
	print("[ALERT]: Routine loaded. Mining white gold at Rakblood.")
	bronze_golem = %A_WorkingDir%\img\monster\bronze_golem.png
	count := 1
	start_time := A_TickCount 

	potion = potion_of_mining_superior
	teleport = rakblood_teleport

	rakblood_to_ore := [new Coordinate(30, 71), new Coordinate(25, 62), new Coordinate(18, 55)
					  , new CombatCoordinate(14, 50), new Coordinate(13, 38), new Coordinate(10, 30)
					  , new Coordinate(7, 20)]

	Loop {
		use_potion := False
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))
		move(37, 65)
		open_chest(east)
		deposit_all()
		if (enable_potion_use and is_potted(potion)) {
			use_potion := True
			print("[TASK]: Repotting", 1)
			withdraw_one(potion)
		}
		withdraw(teleport)

		walk_path(rakblood_to_ore)

		if (use_potion) {
			use_item(potion)
		}
		harvest(west)
		Loop {
			if (!use_item(teleport)) {
				print("[WARNING]: could not find " . teleport . ", walking back instead")
				walk_path(rakblood_to_ore, 0, True) ; Reversed path
			}
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 34) <= 4 and abs(curr_pos[2] - 68) <= 5)
		count := count + 1
	}
}