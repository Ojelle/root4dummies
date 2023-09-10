extends Polygon2D

var verbindingen #Hier moeten de clearings inkomen (bij maken van de map) waarmee de clearing allemaal verbonden is 
var maxGebouwen
var aantalGebouwen
var selectedClearing = false 
#var LijstGebouwen = [] - SAM - Gebouwen wss niet apart bijhouden maar ook als child toevoegen? Ik zou denken van wel

@onready var warrior_class = preload("res://Marquise/Marquise_warrior.tscn")
@onready var clearing = $"."	#SAM - leg nog eens uit waarom we onszelf moeten preloaden?

var baseColor : Color = Color(.78, .32, .09, 1)
var hoverColor : Color = Color("CHARTREUSE")
var selectedColor : Color = Color("CYAN")

signal sig_pressed(clearing)

# Called when the node enters the scene tree for the first time.
func _ready():
	#Aantal gebouwen wordt geset bij 'worldGen' om bvb ruines aan te duiden
	#Nee, niet gereset, ik kan hem van daar incrementen met 1 per ruine
	aantalGebouwen = 0
	pass


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
	#print(from, ", ", to)

func add_building(currentPlayer,buildingType):
	#SAM - hier ga ik wat op het gevoel af wat een goede methode is om een specifiek gebouw toe te voegen. Ik vermoed echter dat ik dit beter opzoek hoe ik dit 'netjes' kan doen. 
	#Mijn gevoel zegt een nieuwe scene maken 'MarquiseBuilding' waarbij ik de drie icoontjes inlaad, en afhankelijk van de argumenten van wat het moet zijn er 2 onzichtbaar zet en het derde center op de plaats waar hij moet staan
	
	pass

func setSelectedClearing():
	color = selectedColor
	selectedClearing = true
	
	
func setUnselectedClearing():
	color = baseColor
	selectedClearing = false

func _on_button_mouse_entered():
	if selectedClearing == false: 
		clearing.color = hoverColor


func _on_button_mouse_exited():
	if selectedClearing == false: 
		color = baseColor


func _on_button_pressed():
	sig_pressed.emit(self)

