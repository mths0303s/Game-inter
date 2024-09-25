extends Area2D
@onready var anim = $anim

var is_active = false

func _on_body_entered(body):
	print("O player entrou no checkpoint!")
	if body.name != "player" or is_active:
		return
	activate_checkpoint()
	
func activate_checkpoint():
	print("O player ativou o checkpoint!")
	anim.play("Out")
	Globals.current_checkpoint = self
	is_active = true


func _on_anim_animation_finished():
	if anim.animation == "Out":
		anim.play("Idle")
