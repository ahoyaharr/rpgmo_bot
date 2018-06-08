main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Farming.")
	seed = wheat_seed

	Loop, 5 {
		move(11, 10)
		open_chest(east)
		deposit_all()
		withdraw(seed)
		Sleep, 500
		close_chest()
		Sleep, 500

		current_offset := 3 * (A_Index - 1) ; Gives the positional offset 

		; Planting loop. Iter1 = rake, Iter2 = seed.
		Loop, 2 {
			move(11 + current_offset, 10)
			move(11 + current_offset, 17)
			reset_queue() ; Clears the queue and enters queue population mode 
			Loop, 16 { ; Populating queue
				print("adding relative (1" . ", " . A_Index . ")")
				relative_click(1, A_Index - 8) ; Click up row
			}
			Loop, 16 {
				print("adding relative (-1" . ", " . A_Index . ")")
				relative_click(-1, 9 - A_Index) ; Click down row
			}
			execute_queue()
		}
		move(11 + current_offset, 10)
	}

	; Harvesting loop 
	Loop, 5 {
		current_offset := 3 * (A_Index - 1) ; Gives the positional offset 
		; Planting loop. Iter1 = rake, Iter2 = seed.
		move(11 + current_offset, 10)
		move(11 + current_offset, 17)
		reset_queue() ; Clears the queue and enters queue population mode 
		Loop, 16 { ; Populating queue
			print("adding relative (1" . ", " . A_Index . ")")
			relative_click(1, A_Index - 8) ; Click up row
		}
		Loop, 16 {
			print("adding relative (-1" . ", " . A_Index . ")")
			relative_click(-1, 9 - A_Index) ; Click down row
		}
		execute_queue()
		move(11 + current_offset, 10)

		relative_move(-current_offset, 0)

		move(11, 10)
		open_chest(east)
		deposit_all()
		Sleep, 500
		close_chest()
		Sleep, 500
	}
}