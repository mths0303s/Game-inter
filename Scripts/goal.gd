extends Area2D
@onready var anim = $anim
@onready var transition = get_parent().get_node("transition")
@export var next_level :  String = ""
@onready var color_rect: ColorRect = $"../transition/color_rect"


func _on_body_entered(body):
	print("O player encontrou o troféu!")
	anim.play("moving")
	if body.name == "player" and !next_level == "":
		transition.change_scene(next_level)
		
	else:
		print("No scene loaded")
		transition.show_new_scene()


func _on_body_exited(body):
	print("O player deixou o troféu!")

func show_new_scene():
	var show_transition = get_tree().create_tween()
	show_transition.tween_property(color_rect, "threshold", 0.0, 0.5).from(1.0)


func _on_anim_animation_finished():
	if anim.animation == "moving":
		anim.play("static")
