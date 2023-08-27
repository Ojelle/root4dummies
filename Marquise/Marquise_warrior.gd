extends Sprite2D

var amount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func adjustAmount(change):
	if(amount + change > 0):
		amount += change
	else:
		queue_free()

