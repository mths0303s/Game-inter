extends Node2D

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")
@onready var camera := $camera as Camera2D
@onready var control = $HUD/control
@onready var transition: CanvasLayer = $transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.temp_position = $Marker2D
	Globals.player = player
	Globals.player.follow_camera(camera)
	control.time_is_up.connect(reload_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func reload_game():
	print("Reload game")
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	player.reload_game_player()
	Globals.player = player
	Globals.respawn_player()
	Globals.player.follow_camera(camera)
	control.time_is_up.connect(reload_game)
	#get_tree().reload_current_scene()
