extends Node2D

var IsClearingLinked
var WarriorsToBeMoved = 0
var moveInProgress = false #stond net boven functie 'move'
var currentPlayer
var buildingType




@onready var buttons = $Buttons

@onready var clearing_1 = $Clearing1
@onready var clearing_2 = $Clearing2
@onready var clearing_3 = $Clearing3
@onready var clearing_4 = $Clearing4

@onready var faction_marquise_de_cat = $FactionMarquiseDeCat


var currentClearing



func _ready(): 
	faction_marquise_de_cat.hide()
	#buttons.hide()
	#SAM - Mijn buikgevoel zegt dat er een 'start of game' fase moet zijn. Hierbij zal ik bvb de knoppen zichtbaar maken na een eerste maal het selecteren van een clearing.
	#Hierdoor zou het ook niet meer nodig zijn om kunstmatig een willekeurige clearing als eerste geselecteerde clearing te kiezen
	#Vermoedelijk is dit  op te vangen door een 'start van uw beurt' te gebruiken, want de laatst geselecteerde clearing van een tegenstander is ook niet relevant voor u
	
	clearing_1.verbindingen = [clearing_2,clearing_3]
	clearing_2.verbindingen = [clearing_1,clearing_3,clearing_4]
	clearing_3.verbindingen = [clearing_1,clearing_2,clearing_4]
	clearing_4.verbindingen = [clearing_2,clearing_3]
	
	clearing_1.maxGebouwen = 1
	clearing_2.maxGebouwen = 2
	clearing_3.maxGebouwen = 3
	clearing_4.maxGebouwen = 4
	
	buttons.sig_recruit.connect(recruit)
	buttons.sig_move.connect(move)
	buttons.sig_buildGeklikt.connect(buildGeklikt)
	buttons.sig_slideramountWarriors.connect(setAmountWarriorsToBeMoved)
	
	faction_marquise_de_cat.sig_buildGekozen.connect(buildGekozen)

	
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

func buildGeklikt():
	faction_marquise_de_cat.show()


func buildGekozen(currentPlayer,buildingType):
	currentClearing.add_building(currentPlayer,buildingType)
	faction_marquise_de_cat.hide()

	
func move():
	moveInProgress = true
	
	
func pressed_clearing(clearing):
	
	if(moveInProgress):
		if(checkIsClearingConnected(currentClearing,clearing)==true):
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
			Events.sig_WarriorsInClearing.emit(MaxWarriors) #JELLE - check of ik dit niet kan doen met get.node(jadejadejade)

			buttons.get_node("Move").show() 	
				#SAM - DE CHECK OF ER WARRIORS ZIJN MOET QUASI CONTINU GEBEUREN, ALS ER KOMEN MOET DE KNOP ZICHTBAAR WORDEN
				#SAM - VOLGENS MIJ NIET IN PHYSICS PROCESS, EERDER ALS ER EEN WARRIOR GEINSTANTIEERD WORDT IN DE CLEARING
				#SAM - ER ZIJN MOGELIJKS MEER EVENTS DAN ENKEL EEN *BEWUSTE* RECRUIT/MOVE WAARDOOR ER WARRIORS IN EEN CLEARING KOMEN
		else:
			buttons.get_node("Move").hide()
		
	if (clearing.aantalGebouwen<clearing.maxGebouwen): #moet ik hier eigenlijk ook een functie van maken? Voor de leesbaarheid beter wel zeker? 
														#func IsErNogEenBouwplaatsVrij
		buttons.get_node("Build").show() 	
	
	else:
		buttons.get_node("Build").hide() 	








func checkIsClearingConnected(clearingA,clearingB):
	if clearingA.verbindingen.find(clearingB) != -1:
		return true
	else:
		return false







	#var deltaX = ClearingB.global_position[0]-ClearingA.global_position[0]
	#var deltaY = ClearingB.global_position[1]-ClearingA.global_position[1]
#	$MarquiseDeCatWarrior2.move_local_x(deltaX)
#	$MarquiseDeCatWarrior2.move_local_y(deltaY)


#on recruit - move zichtbaar maken
#bouwen
#custom buttons
