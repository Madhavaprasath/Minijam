extends KinematicBody2D

signal Player_turn_finished()

var direction_vector=Vector2()
var speed=10.0
var velocity=Vector2()
var is_moving=false
onready var level=get_parent()



func _ready() -> void:
	set_physics_process(false)
	yield(get_tree().create_timer(0.5),"timeout")
	set_physics_process(true)
	$Timer.start(2.5)
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
				emit_signal("Player_turn_finished")

func _unhandled_key_input(event: InputEventKey) -> void:
	if(level.player_turn):
		calculate_exteme_points()
		get_movement(event)

func calculate_exteme_points():
	position.x=clamp(position.x,32,(1024-32))
	position.y=clamp(position.y,32,(600-32))


func _on_Timer_timeout():
	if(!is_moving):
		emit_signal("Player_turn_finished")
	elif(is_moving):
		is_moving=false


func _on_Level_start_player_timer():
	$Timer.start(2)
