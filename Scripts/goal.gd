extends Area2D
@onready var anim = $anim
@onready var transition = get_parent().get_node("transition")
@export var next_level :  String = ""


func _on_body_entered(body):
	print("O player encontrou o troféu!")
	anim.play("moving")
	if body.name == "player" and !next_level == "":
		transition.change_scene(next_level)
	else:
		print("No scene loaded")


func _on_body_exited(body):
	print("O player deixou o troféu o troféu!")
	anim.play("idle")
