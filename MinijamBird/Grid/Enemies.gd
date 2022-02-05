extends Node2D

var enemies=[]
var row_vector=[]
var colum_vector=[]

""" I need to spwan the items if the array is empty and do no movement and check for
The object overlapping while spwaning and then Move the sprites"""

var movable_dict={
	0:preload("res://Moving_items/Moving_items.tscn")
}

func _ready():
	var i=32
	while(i<=(1024-32)):
		row_vector.append(i)
		i+=64
	print(row_vector)
	i=32
	while(i<=(600-32)):
		colum_vector.append(i)
		i+=64
	print(colum_vector)
	start_enemey_move()


func start_enemey_move():
	randomize()
	if(enemies!=[]):
		for i in enemies:
			i.do_movement()
		var random=randi()%1
		print(random)
		if(random==1):
			var rand=randi()%3
			var i=0
			while(i<rand):
				#match groups 
				i+=1
	else:
		var temp_array_positions=[]
		var rand=choose([1,2,3,4])
		var i=0
		while(i<rand):
			#var child_scene=movable_dict[0].instance()
			#child_scene.current=choose([0,1])
			var c=0
			if(c==0):
				var a=choose(row_vector.duplicate(false))
				if(a in temp_array_positions):
					a+=a
				var factor=choose([-1,1])
				var pos=Vector2(a,-32) if factor==1 else Vector2(a,(600+32))
				print(pos)
			i+=1
	

func choose(arr):
	randomize()
	arr.shuffle()
	return arr.pop_front()


