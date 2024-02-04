extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body):
	if (body.name == "Main_Charecter"):	
		queue_free()
		game_manager.add_point()
