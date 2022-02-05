extends KinematicBody2D

var direction_vector=Vector2()
var speed=10.0
var velocity=Vector2()

func _ready() -> void:
	set_physics_process(false)
	yield(get_tree().create_timer(0.5),"timeout")
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	if($Floor_check.get_overlapping_areas())==[]:
		print("die")
		queue_free()



func get_movement(event):
	var directions={
		"ui_left":Vector2.LEFT,
		"ui_right":Vector2.RIGHT,
		"ui_up":Vector2.UP,
		"ui_down":Vector2.DOWN
	}
	for dir in directions.keys():
		if(event.is_action_pressed(dir)):
			var target_position=global_position+(directions[dir]*Vector2(64,64))
			var result=((target_position.x>=32 and target_position.x<=(1024-32)) and (target_position.y>=32 and target_position.y<=(600-32)))
			if result:
				$Tween.interpolate_property(self,"position",global_position,global_position+(directions[dir]*Vector2(64,64)),
							1.0/speed,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
				$Tween.start()

func _unhandled_key_input(event: InputEventKey) -> void:
	calculate_exteme_points()
	get_movement(event)

func calculate_exteme_points():
	position.x=clamp(position.x,32,(1024-32))
	position.y=clamp(position.y,32,(600-32))
