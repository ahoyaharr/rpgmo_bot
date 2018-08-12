main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Farming shrooms in the Lost Woods.")

	food = cooked_lion_fish
	teleport = whiland_teleport
	world := 0

	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest.
		move(29, 92) 

		; Store items and heal up.
		open_chest(east)
		deposit_all()
		withdraw(food)
		eat()
		deposit_all()
		withdraw(teleport)

		; Jump to correct world 
		Sleep, 5000
		send_command("world", mod(world++, 2) + 1)
		Loop {
			Sleep, 500
		} Until (!main_menu_is_open())

		; Move to Lost Woods
		move(20, 87)
		move(12, 91)
		move(9, 90)
		move_west(1)
		sleep, 1000

		; Now in Lost Woods
		move(83, 24)

		move(87, 30)
		attempt_combat(1, north) ; Grizzly

		move(86, 36)
		attempt_combat(1, north) ; Grizzly

		move(77, 39)
		move(71, 36)
		attempt_combat(1, west) ; Golden shroom

		move(77, 27)
		attempt_combat(1, south) ; Golden shroom

		move(75, 21)
		attempt_combat(1, south) ; Golden shroom

		move(69, 14)
		attempt_combat(1, south) ; Golden shroom

		move(65, 20)
		attempt_combat(1, north) ; Glowing shroom

		move(58, 19)
		attempt_combat(1, east) ; Golden shroom

		move(53, 24)
		attempt_combat(1, north) ; Glowing shroom

		move(50, 28)
		attempt_combat(1, north) ; Glowing shroom

		move(49, 23)
		attempt_combat(1, east) ; Golden shroom

		move(43, 27)
		attempt_combat(1, north) ; Glowing shroom

		move(44, 21)
		attempt_combat(1, north) ; Golden shroom

		move(45, 15)
		attempt_combat(1, south) ; Golden shroom

		move(54, 13)
		attempt_combat(1, east) ; Golden shroom

		move(45, 15)
		move(38, 21)
		attempt_combat(1, west) ; Glowing shroom 

		move(29, 23)
		attempt_combat(1, north) ; Glowing shroom

		move(27, 16)
		attempt_combat(1, north) ; Glowing shroom 

		move(24, 14)
		attempt_combat(1, north) ; Golden shroom 

		move(19, 12)
		attempt_combat(1, east) ; Glowing shroom

		move(14, 15)
		attempt_combat(1, south) ; Golden shroom

		move(16, 20)
		attempt_combat(1, north) ; Glowing shroom 

		move(16, 27)
		attempt_combat(1, west) ; Glowing shroom 

		move(15, 33)
		attempt_combat(1, west) ; Golden shroom 

		move(15, 44)
		move(15, 49)
		attempt_combat(1, north) ; Glowing shroom

		move(22, 50)
		attempt_combat(1, south) ; Glowing shroom 

		move(23, 58)
		attempt_combat(1, east) ; Golden shroom 

		move(15, 59)
		attempt_combat(1, west) ; Golden shroom 

		move(15, 65)
		attempt_combat(1, north) ; Golden shroom 

		move(20, 64)
		attempt_combat(1, east) ; Golden shroom

		load_pet_inventory()

		;; Jump to correct world
		Sleep, 5000
		send_command("world", mod(world++, 2) + 1)
		
		Loop {
			Sleep, 500
		} Until (!main_menu_is_open())
		Sleep, 2500

		load_pet_inventory()

		move(20, 64)
		attempt_combat(1, east) ; Golden shroom

		move(15, 65)
		attempt_combat(1, north) ; Golden shroom 

		move(15, 59)
		attempt_combat(1, west) ; Golden shroom

		move(23, 58)
		attempt_combat(1, east) ; Golden shroom

		move(22, 50)
		attempt_combat(1, south) ; Glowing shroom

		move(15, 49)
		attempt_combat(1, north) ; Glowing shroom

		move(15, 44)
 		move(15, 33)
		attempt_combat(1, west) ; Golden shroom 

		move(16, 27)
		attempt_combat(1, west) ; Glowing shroom 

		move(16, 22)
		attempt_combat(1, south) ; Glowing shroom 

		move(14, 15)
		attempt_combat(1, south) ; Golden shroom

		move(19, 12)
		attempt_combat(1, east) ; Glowing shroom

		move(24, 14)
		attempt_combat(1, north) ; Golden shroom 

		move(27, 16)
		attempt_combat(1, north) ; Glowing shroom

		move(29, 23)
		attempt_combat(1, north) ; Glowing shroom

		move(38, 21)
		attempt_combat(1, west) ; Glowing shroom 
		move(45, 15)

		move(54, 13)
		attempt_combat(1, east) ; Golden shroom

		move(45, 15)
		attempt_combat(1, south) ; Golden shroom

		move(44, 21)
		attempt_combat(1, north) ; Golden shroom

		move(43, 27)
		attempt_combat(1, north) ; Glowing shroom

		move(49, 23)
		attempt_combat(1, east) ; Golden shroom

		move(50, 28)
		attempt_combat(1, north) ; Glowing shroom

		move(53, 24)
		attempt_combat(1, north) ; Glowing shroom

		move(58, 19)
		attempt_combat(1, east) ; Golden shroom

		move(65, 20)
		attempt_combat(1, north) ; Glowing shroom

		move(69, 14)
		attempt_combat(1, south) ; Golden shroom

		move(75, 21)
		attempt_combat(1, south) ; Golden shroom

		move(77, 27)
		attempt_combat(1, south) ; Golden shroom

		move(73, 31)
		move(71, 36)
		attempt_combat(1, west) ; Golden shroom

		Loop {
			use_item(teleport)
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 28) <= 4 and abs(curr_pos[2] - 93) <= 5)

		count := count + 1
	}
}