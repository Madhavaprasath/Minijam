extends Area2D

var current=0
var factor=Vector2()

func _ready():
	if(current==0):
		if(position.x>0):
			factor=Vector2(1,0)
		else:
			factor=Vector2(-1,0)
	elif(current==1):
		if(position.y>0):
			factor=Vector2(0,-1)
		else:
			factor=Vector2(0,1)


func do_movement():
	var target=global_position+factor*Vector2(64,64)
	$Tween.interpolate_property(self,global_position,target,1.0/10.0,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()
