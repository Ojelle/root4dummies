extends Polygon2D

var verbindingen #Hier moeten de clearings inkomen (bij maken van de map) waarmee de clearing allemaal verbonden is 
@onready var warrior_class = preload("res://Marquise/Marquise_warrior.tscn")
@onready var clearing = $"."

var baseColor : Color = Color(.78, .32, .09, 1)
var hoverColor : Color = Color("CHARTREUSE")

signal sig_pressed(clearing)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var warriorInstance
func change_warrior(amount):
#	var warrior = get_node("warrior")
	if(warriorInstance == null):
		warriorInstance = warrior_class.instantiate()
		add_child(warriorInstance)
		
	warriorInstance.adjustAmount(amount)

func move_from(clearing, amount):
	clearing.change_warrior(-1 * amount)
	self.change_warrior(amount)#self. is niet nodig
	var from = self.warriorInstance.amount
	var to = clearing.warriorInstance.amount
	print(from, ", ", to)

func _on_button_mouse_entered():
	clearing.color = hoverColor
	pass # Replace with function body.


func _on_button_mouse_exited():
	color = baseColor
	pass # Replace with function body.


func _on_button_pressed():
	print("clicked")
	sig_pressed.emit(self)
	pass # Replace with function body.
