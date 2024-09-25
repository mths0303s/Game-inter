extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation := $Anim as AnimatedSprite2D
@onready var remote_transform := $Remote as RemoteTransform2D
var is_jumping := false
@export var player_life := 10
var knockback_vector := Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if is_on_floor():
			if is_jumping:
				animation.play("Jump")
			else:
				animation.play("Run")
		else:
			if is_jumping:
				animation.play("Jump")
			else:
				animation.play("Fall")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animation.play("Idle")
		else:
			if is_jumping:
				animation.play("Jump")
			else:
				animation.play("Fall")
				
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	move_and_slide()
	


func _on_hurtbox_body_entered(_body: Node2D) -> void:
#	if body.is_in_group("perigos"):
#		queue_free()
	if player_life < 0:
		queue_free()
	else:
		if $Ray_Right.is_colliding():
			take_damage(Vector2(-200, -200))
		elif $Ray_Left.is_colliding():
			take_damage(Vector2(200, -200))
		
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knoback_force := Vector2.ZERO, duration := 0.25):
	player_life -= 1
	if knoback_force != Vector2.ZERO:
		knockback_vector = knoback_force
		
		var knoback_tween := get_tree().create_tween()
		knoback_tween.tween_property(self, "knoback_vector", Vector2.ZERO, duration)

func reload_game_player():
	print("Reload game player")
	await get_tree().create_timer(0).timeout
	get_tree().reload_current_scene()
