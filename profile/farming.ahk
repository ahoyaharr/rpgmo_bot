main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Mining white gold at Rakblood.")
	seed = wheat_seed
	Loop {
		move(11, 10)
		open_chest(east)
		deposit_all()
		withdraw(seed)
		Sleep, 500
		close_chest()
		Sleep, 500
		reset_queue() ; Clears the queue and enters queue population mode 
		i := 1
		Loop, 10 { ; Populating queue
			print("adding relative (+/-" . 1 . ", " . A_Index . ")")
			relative_move(1, i)
			relative_move(-1, i)
			i := i + 1
		}
		execute_queue()
	}
}