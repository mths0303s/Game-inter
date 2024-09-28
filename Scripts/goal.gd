extends Area2D
@onready var anim = $anim



func _on_body_entered(body):
	print("O player encontrou o troféu!")
	anim.play("moving")


func _on_body_exited(body):
	print("O player deixou o troféu o troféu!")
	anim.play("idle")
