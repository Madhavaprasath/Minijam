extends Node2D

signal enemey_turn_finished()

var enemies=[]
var row_vector=[]
var colum_vector=[]


""" I need to spwan the items if the array is empty and do no movement and check for
The object overlapping while spwaning and then Move the sprites"""

var movable_dict={
	0:preload("res://Moving_items/Moving_items.tscn")
}
onready var level=get_parent()

func _ready():
	var i=32
	while(i<=(1024-32)):
		row_vector.append(i)
		i+=64
	i=32
	while(i<=(600-32)):
		colum_vector.append(i)
		i+=64


func start_enemey_move():
	randomize()
	if(enemies!=[]):
		for i in enemies:
			i.do_movement()
		var rand=choose([0,1])
		if(rand==1):
			spwan_snow_balls()
		emit_signal("enemey_turn_finished")
	else:
		spwan_snow_balls()

func choose(arr):
	randomize()
	arr.shuffle()
	return arr.pop_front()

func spwan_snow_balls():
	var temp_array_positions=[]
	var rand=choose([0,1])
	var i=0
	while(i<rand):
		var child_scene=movable_dict[0].instance()
		var pos=Vector2()
		var factor
		child_scene.current=choose([0,1])
		if(child_scene.current==0):
			var a=choose(row_vector.duplicate(false))
			if(a in temp_array_positions):
				a+=a
			factor=choose([-1,1])
			pos=Vector2(a,-32) if factor==1 else Vector2(a,(600+32))
		if(child_scene.current==1):
			var a=choose(colum_vector.duplicate(false))
			if(a in temp_array_positions):
				a+=a
			factor=choose([-1,1])
			pos=Vector2(-32,a) if factor==1 else Vector2((1024+32),a)
		child_scene.global_position=pos
		add_child(child_scene)
		enemies.append(child_scene)
		i+=1
	emit_signal("enemey_turn_finished")

