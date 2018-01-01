reset_queue() {
	Click, 187, 290 Left, 1
	Sleep, 250
	Send, {Space}
	Sleep, 250
	Send, {LControl}
}

execute_queue() {
	send, {Space}
}