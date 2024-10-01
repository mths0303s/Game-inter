extends Area2D
@onready var collision = $collision as CollisionShape2D
@onready var fire = $fire as Sprite2D


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.name == "player" && body.has_method("take_damage"):
		print("O player está no fogo!")
		body.reload_game_player()
