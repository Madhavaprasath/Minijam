extends Node2D

signal start_player_timer()

onready var tilemap=get_node("TileMap")

var scene_dict={
	0:preload("res://Tiles/Tile_Static.tscn"),
	1:preload("res://Tiles/Tile_falling.tscn")
}


onready var half_cell_size=tilemap.cell_size*0.5
onready var tiles=get_node("Tiles")
onready var enemies=get_node("Enemies")

var player_turn=true



func _ready():
	put_scene_into_tile()
func put_scene_into_tile():
	
	for tile_position in tilemap.get_used_cells():
		
		var tile_id= tilemap.get_cell(tile_position.x,tile_position.y)
		#now match with the Tile location
		if(scene_dict.has(tile_id)):
			var current_scene=scene_dict[tile_id]
			place_scene(current_scene,tile_position)


func place_scene(scene,tile_position):
	if tilemap.get_cellv(tile_position)!=tilemap.INVALID_CELL:
		tilemap.set_cellv(tile_position,-1)
		#if there is auto tile we are planning 
		tilemap.update_bitmask_region()
	if scene!=null:
		var obj=scene.instance()
		obj.global_position=(tilemap.map_to_world(tile_position)+half_cell_size)
		tiles.add_child(obj)

func make_circles(radius):
	if(radius>3):
		var i=2
		while(i<=radius):
			i+=1
		while(i>=2):
			i-=1



func _on_Player_Player_turn_finished():
	player_turn=false
	yield(get_tree().create_timer(0.5),"timeout")
	enemies.start_enemey_move()



func _on_Enemies_enemey_turn_finished():
	player_turn=true
	emit_signal("start_player_timer")
