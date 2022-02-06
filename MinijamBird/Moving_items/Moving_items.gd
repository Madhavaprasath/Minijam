extends Area2D

signal Dead()

var current=0
var factor=Vector2()
var collision=false


func _ready():
	if(current==0):
		if(position.y<0):
			factor=Vector2(0,1)
		else:
			factor=Vector2(0,-1)
	elif(current==1):
		if(position.x>0):
			factor=Vector2(-1,0)
		else:
			factor=Vector2(1,0)


func do_movement():
	var target=factor*Vector2(64,64)
	$Tween.interpolate_property(self,"position",global_position,global_position+(target),
	1.0/10.0,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()

func _check_collision():
	collision=true



func _on_Moving_items_body_entered(body):
	print("Dead")
	emit_signal("Dead")
	body.do_collision_physics(factor)
