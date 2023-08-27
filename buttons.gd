extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("haha, ik heb op een knop gedruk")
	
	var deltaX = 5#ClearingB.global_position[0]-ClearingA.global_position[0]
	var deltaY = 5#ClearingB.global_position[1]-ClearingA.global_position[1]
	$MarquiseDeCatWarrior3.move_local_x(deltaX)
	$MarquiseDeCatWarrior3.move_local_y(deltaY)
	
	pass # Replace with function body.



