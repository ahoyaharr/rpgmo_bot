main() {
	initialise()
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	food := "cooked_bass"
	teleport := "dorpat_teleport"

	spell_usage := False
	spells := ["earth_wave", "water_wave", "fire_wave"]

	bank_chest := new Coordinate(22, 18)
	dorpat_to_start := [new Coordinate(20, 27), new Coordinate(25, 30)]

	rat_loop := [new Coordinate(25, 31), new Coordinate(24,36), new Coordinate(24,39)
				  ,new Coordinate(27,39), new Coordinate(29,41), new Coordinate(36,38)
				  ,new Coordinate(37,34), new Coordinate(38,30), new Coordinate(39,25)
				  ,new Coordinate(37,22), new Coordinate(33,27), new Coordinate(31,33)
				  ,new Coordinate(27,33)]

	print("[ALERT]: Routine loaded. Fighting white rats by Dorpat.")
	
	bank_chest.travel()

	Loop {
		; Move to Reval chest 
		open_chest(south)
		deposit_all()
		if (spell_usage) {
			open_bag(True)
			for each, spell in spells {
				print("[ALERT] Reloading spellbook with " . spell)
				withdraw(spell)
				loop, 20 {
					if (!use_item(spell)) {
						break
					}
				}
				deposit_all()
			}
			open_bag(False)
		}
		withdraw(teleport)
		sleep, 2500
		withdraw(food)
		sleep, 2500

		; Move to Pernau
		print("[ALERT] Walking to rats.")
		walk_path(dorpat_to_start)

		print("[ALERT]: Beginning to fight " . monsters)
		Loop {
			for each, rat in rat_loop {
				if (!rat.fight()) {
					break 
				}
				count := count + 1
				print("[STATUS]: " . count . " kills in " . formatted_time(start_time, A_TickCount)) 
				
				if (mod(count, 100) == 0) {
					destroy_all()
				}
			}
		} until (!eat(3)) ; Loop until the player is hurt and fails to eat.

		print("[ALERT]: Out of food. Returning to Dorpat.")
		Loop { ; Use dorpat teleport until within area of starting location
			use_item(teleport)
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5)
	}
}
