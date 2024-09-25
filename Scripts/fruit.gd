extends Area2D

var fruits := 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	$animFruit.play("collected")
	await $Collision.call_deferred("queue_free")
	Globals.fruits += fruits
	print(Globals.fruits)


func _on_anim_fruit_animation_finished():
	queue_free()
