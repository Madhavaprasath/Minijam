extends Area2D

class_name Tiles





func on_enetered_tile(body):
	pass


func _on_Tile_static_body_entered(body: Node) -> void:
	on_enetered_tile(body)
