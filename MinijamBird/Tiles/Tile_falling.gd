extends Tiles

var turns=3



func on_enetered_tile(body):
	turns-=1
	
func _on_Tile_falling_body_exited(body):
	if(turns==0):
		$AnimationPlayer.play("Falling")
