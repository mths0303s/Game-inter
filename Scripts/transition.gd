extends CanvasLayer

@onready var color_rect: ColorRect = $color_rect

func change_scene(path, delay = 2.5):
	var scene_transition = get_tree().create_tween()
	scene_transition.tween_property(color_rect, "threshold", 1.0, 1.5)
	await scene_transition.finished
	assert(get_tree().change_scene_to_file(path) == OK)
