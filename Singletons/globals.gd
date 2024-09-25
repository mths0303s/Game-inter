extends Node
var fruits := 0
var player = null
var current_checkpoint = null
var temp_position = null

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
