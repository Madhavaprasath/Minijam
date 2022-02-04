extends Node2D



onready var tilemap=get_node("TileMap")

var scene_dict={}

onready var half_cell_size=tilemap.cell_size*0.5
onready var tiles=get_node("Tiles")


func _ready():
	pass

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
