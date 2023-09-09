extends Node2D

var IsClearingLinked
var WarriorsToBeMoved = 0
var moveInProgress = false #stond net boven functie 'move'

signal sig_MaxWarriorsToBeMoved


@onready var buttons = $Buttons
@onready var clearing_1 = $Clearing1
@onready var clearing_2 = $Clearing2
@onready var clearing_3 = $Clearing3
@onready var clearing_4 = $Clearing4

var currentClearing



func _ready(): # Called when the node enters the scene tree for the first time.
	
	#buttons.hide()
	#SAM - Mijn buikgevoel zegt dat er een 'start of game' fase moet zijn. Hierbij zal ik bvb de knoppen zichtbaar maken na een eerste maal het selecteren van een clearing.
	#Hierdoor zou het ook niet meer nodig zijn om kunstmatig een willekeurige clearing als eerste geselecteerde clearing te kiezen
	#Vermoedelijk is dit  op te vangen door een 'start van uw beurt' te gebruiken, want de laatst geselecteerde clearing van een tegenstander is ook niet relevant voor u
	
	clearing_1.verbindingen = [clearing_2,clearing_3]
	clearing_2.verbindingen = [clearing_1,clearing_3,clearing_4]
	clearing_3.verbindingen = [clearing_1,clearing_2,clearing_4]
	clearing_4.verbindingen = [clearing_2,clearing_3]
	
	clearing_1.MaxGebouwen = 1
	clearing_2.MaxGebouwen = 2
	clearing_3.MaxGebouwen = 3
	clearing_4.MaxGebouwen = 4
	
	buttons.sig_recruit.connect(recruit)
	buttons.sig_move.connect(move)
	buttons.sig_build.connect(build)
	buttons.sig_slideramountWarriors.connect(setAmountWarriorsToBeMoved)
	
	clearing_1.sig_pressed.connect(pressed_clearing)
	clearing_2.sig_pressed.connect(pressed_clearing)
	clearing_3.sig_pressed.connect(pressed_clearing)
	clearing_4.sig_pressed.connect(pressed_clearing)
	
	currentClearing = clearing_1	#DitMoetWeg - mechanisme vervangen door knoppen pas zichtbaar te maken na selecteren van de eerste clearing
									#Dit geeft effectief enkel problemen bij de eerste maal recruiten/moven. 


func _physics_process(delta):
	pass

	
func recruit():
	currentClearing.change_warrior(1)
	
func setAmountWarriorsToBeMoved(amount):
	WarriorsToBeMoved = amount
	
func destroy():
#	currentClearing.remove_warrior()
	pass

func build():
	pass


func move():
	moveInProgress = true
	
	
func pressed_clearing(clearing):
	
	if(moveInProgress):
		if(CheckIsClearingConnected(currentClearing,clearing)==true):
			clearing.move_from(currentClearing, WarriorsToBeMoved)	# hier de sanitized user input plaatsen, vlak voor move progressen vraag ik input
			moveInProgress = false
			#Ik zou willen op dit punt de doelclearing intstellen als nieuwe 'geselecteerde' clearing, maar dan moet ik ook mn max van de move slider aanpassen. 
			#currentClearing=clearing #DIT IS EEN (VOORLOPIGE) DESIGNKEUZE
			Events.sig_ValidMoveEnded.emit()
		else:
			print("clearingsNotConnected")
			#soort rode flash /visuele waarschuwing geven dat dit geen geldig doel was
	else:
		currentClearing = clearing
		
		var MaxWarriors = 0		#SAM - IK HEB HET GEVOEL DAT DIT HIER NIET OP ZIJN PLAATS STAAT - DAT DIT OFWEL EEN FUNCTIE MOET ZIJN OF VIA IETS ANDERS MOET AANGEROEPEN WORDEN
		if clearing.get_node("warrior") != null:
			MaxWarriors = clearing.warriorInstance.currentAmount()
			Events.sig_WarriorsInClearing.emit(MaxWarriors)
			sig_MaxWarriorsToBeMoved.emit(MaxWarriors)
			buttons.get_node("Move").show() 	
				#SAM - DE CHECK OF ER WARRIORS ZIJN MOET QUASI CONTINU GEBEUREN, ALS ER KOMEN MOET DE KNOP ZICHTBAAR WORDEN
				#SAM - VOLGENS MIJ NIET IN PHYSICS PROCESS, EERDER ALS ER EEN WARRIOR GEINSTANTIEERD WORDT IN DE CLEARING
				#SAM - ER ZIJN MOGELIJKS MEER EVENTS DAN ENKEL EEN *BEWUSTE* RECRUIT/MOVE WAARDOOR ER WARRIORS IN EEN CLEARING KOMEN
		else:
			buttons.get_node("Move").hide()
		

func CheckIsClearingConnected(clearingA,clearingB):
	if clearingA.verbindingen.find(clearingB) != -1:
		return true
	else:
		return false







	#var deltaX = ClearingB.global_position[0]-ClearingA.global_position[0]
	#var deltaY = ClearingB.global_position[1]-ClearingA.global_position[1]
#	$MarquiseDeCatWarrior2.move_local_x(deltaX)
#	$MarquiseDeCatWarrior2.move_local_y(deltaY)
