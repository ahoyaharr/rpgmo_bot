main(profile) {
	initialise()
	monsters = sapphire_dragon
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	print("[ALERT]: Routine loaded. Fighting " . monsters)
	Loop {
		; Move to Dorpat chest 
		move(22, 18)
		open_chest(south)
		deposit_all()
		withdraw("dorpat_teleport")
		sleep, 2500
		withdraw("cooked_white_shark")
		sleep, 2500

		; Move to Dungeon 1
		move(20, 27)
		move(19, 36)
		move(19, 46)
		move(20, 57)
		move(18, 66)
		move(18, 77)
		move(21, 85) ; Will have to fight
		move(25, 89) 
		wait_begin_combat(3) 
		complete_combat()
		move_south(1) ; Enter Dungeon 1
		sleep, 2500

		print("[ALERT]: Beginning to fight " . monsters)
		Loop {
			hazard_check()
			m := StrSplit(monsters, ",")

			Loop % m.MaxIndex() {
			    t := m[a_index]
			    monster = %A_WorkingDir%\img\monsters\%t%.png
				if (attack_nearest(monster) != 0) {
					if (wait_begin_combat(7) = 0) {  ; return 0 if combat begins
						complete_combat(20)
						count := count + 1
						print("[STATUS]: " . count . " kills in " . FormatSeconds(A_TickCount - start_time)) 
					}
					break
				} 
			}
		} until (!eat(10)) ; Loop until the player is hurt and fails to eat.

		print("[ALERT]: Out of food. Returning to Dorpat.")
		Loop { ; Use dorpat teleport until within area of starting location
			use_item("dorpat_teleport")
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5)
	}
}