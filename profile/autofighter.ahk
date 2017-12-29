main(profile) {
	initialise()
	monsters = skeleton,vampire
	count := 0
	start_time := A_TickCount 

	print("[ALERT]: Routine loaded. Autofighting " . monsters)
	Loop {
		eat()
		m := StrSplit(monsters, ",")

		Loop % m.MaxIndex() {
		    t := m[a_index]
		    monster = %A_WorkingDir%\img\%t%.png
			if (attack_nearest(monster) != 0) {
				if (wait_begin_combat(7) = 0) {  ; return 0 if combat begins
					complete_combat(20)
					count := count + 1
					print("[STATUS]: " . count . "monsters have been killed.")
				}
				break
			}
		}
	}
}