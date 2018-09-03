main() {
	initialise()
	print("[ALERT]: Routine loaded. Cutting gems at Dorpat.")
	count := 1
	start_time := A_TickCount 

	gems = uncut_medium_grade_ruby,uncut_low_grade_ruby,uncut_high_grade_emerald

	move(22, 18) 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))

		; Move to chest 
		open_chest(south)
		deposit_all()

		gem_iterable := StrSplit(gems, ",")
		Loop % gem_iterable.MaxIndex() {
		    gem := gem_iterable[a_index]
			if (withdraw(gem)) {
				break
			}
			gem := ""
		}

		if (gem == "") {
			print("[ALERT] Finished cutting!")
			Pause, On
		}
		close_chest()
		
		open_bag(true)
		while (has_item(gem)) {
			use_item(gem)
			sleep, 500
			hazard_check()
		}
		open_bag(false)

		count := count + 1
	}
}