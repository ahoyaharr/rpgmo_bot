main() {
	initialise()
	print("[ALERT]: Routine loaded. Cooking at Cesis.")
	count := 1
	start_time := A_TickCount 

	fish = raw_swordfish, raw_squalidae

	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(61, 62) 
		open_chest(south)
		deposit_all()

		cookables := StrSplit(fish, ",")
		cookable := ""
		Loop % cookables.MaxIndex() {
		    cookable := cookables[a_index]
			if (withdraw(cookable)) {
				break
			}
			cookable := ""
		}

		if (cookable == "") {
			print("[ALERT] Finished cooking!")
			Pause, On
		}
		close_chest()
		
		; Move to fire 
		move(61, 63)
		process(north, cookable)

		count := count + 1
	}
}