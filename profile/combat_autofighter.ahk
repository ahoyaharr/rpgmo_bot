main(profile) {
	initialise()
	monsters = sand_centipede
	count := 0
	start_time := A_TickCount 
	currentWorld := 1


	print("[ALERT]: Routine loaded. Autofighting " . monsters)
	Loop {
		hazard_check()
		eat()
		m := StrSplit(monsters, ",")

		Loop % m.MaxIndex() {
		    t := m[a_index]
		    monster = %A_WorkingDir%\img\monsters\%t%.png
			if (attack_nearest(monster) != 0) {
				if (wait_begin_combat(7) = 0) {  ; return 0 if combat begins
					complete_combat(20)
					count := count + 1
					print("[STATUS]: " . count . "monsters have been killed.")
				}
				break
			} else if (A_Index == m.MaxIndex()) {
				worldNumber := 3
				while (worldNumber == 3 or worldNumber == currentWorld) {
					Random, worldNumber, 1, 5
				}
				currentWorld := worldNumber
				send {enter}/world %worldNumber%
				sleep, 1000
				send {enter}
				sleep, 7500
			}
		}
	}
}