extends Sprite2D

var amount = 0
@onready var warrior = $"."


func _ready():
	pass 



func _process(delta):
	pass
	
func adjustAmount(change):
	if(amount + change > 0):
		amount += change
		$TekstWarrior.text = str(amount)
	else:
		queue_free()

func currentAmount():
	return amount
