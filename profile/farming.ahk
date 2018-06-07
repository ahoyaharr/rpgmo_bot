main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Farming.")
	seed = wheat_seed

	; Planting loop
	Loop, 1 {
		move(11, 10)
		open_chest(east)
		deposit_all()
		withdraw(seed)
		Sleep, 500
		close_chest()
		Sleep, 500

		Loop, 2 {
		move(11, 17)
		reset_queue() ; Clears the queue and enters queue population mode 
			Loop, 16 { ; Populating queue
				print("adding relative (1 . ", " . A_Index . ")
				relative_click(1, A_Index - 8) ; Click up row
			}
			Loop, 16 {
				print("adding relative (-1 . ", " . A_Index . ")
				relative_click(-1, 9 - A_Index) ; Click down row
			}
			execute_queue()
		}
	}

	; Harvesting loop
	Loop, 0 {

	}
}