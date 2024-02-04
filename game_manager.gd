extends Node

@onready var points_label = %PointsLabel

var points = 0
# Called when the node enters the scene tree for the first time.
func add_point():
	points+=1
	points_label.text = "Points: "+str(points)
