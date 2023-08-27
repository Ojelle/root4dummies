extends Node2D

var IsClearingLinked

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Clearing1.verbindingen = [$Clearing2,$Clearing3]
	$Clearing2.verbindingen = [$Clearing1,$Clearing3,$Clearing4]
	$Clearing3.verbindingen = [$Clearing1,$Clearing2,$Clearing4]
	$Clearing4.verbindingen = [$Clearing2,$Clearing3]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	print("test")
	var UserInput
	#var From = AskForClearing()
	
	print("From " , 1)
	#var To = AskForClearing()
	print("To " , 2)
	var From = $Clearing2
	var To = $Clearing3
	
	#ApplyMoveBetweenClearings(From,To)

	if Input.is_action_just_pressed("ui_1"):
		var TempTest = $Clearing1
		var DidIGetInput = 1
		print("al tot hier")
	
	
	
	#if Input.is_action_just_pressed("ui_left"):
	#	UserInput = "Left"
	#if Input.is_action_just_pressed("ui_right"):
	#	UserInput = "Right"
	#print(Input.is_action_just_pressed("TestDuwOpA"))
	
	
	
	
#	ApplyMove(UserInput,$Clearing1,$Clearing2)
#	#TestDuwOpA
#	print(UserInput)
#	print($Clearing1.verbindingen)
#	CheckIsClearingLinked($Clearing1,$Clearing2)
#	var test = $Clearing2.verbindingen[0]
#	$Clearing2.position
#	var deltaX
#	var deltaY
	
	#deltaX = $Clearing.polygons[1]
	
	# - $Clearing2.polygons[1]
	#$MarquiseDeCatWarrior3.move_local_y(deltaX)
	
	
func TestMetPrint():
	print("TestMetPrint")

func ApplyMoveBetweenClearings(ClearingA,ClearingB):
	if CheckIsClearingConnected(ClearingA,ClearingB)==false:
		print("clearings not connected")
		return
	#check child - if warriors present in 'from clearing', otherwise break, if present ask how much
	
	var deltaX = ClearingB.global_position[0]-ClearingA.global_position[0]
	var deltaY = ClearingB.global_position[1]-ClearingA.global_position[1]
	$MarquiseDeCatWarrior2.move_local_x(deltaX)
	$MarquiseDeCatWarrior2.move_local_y(deltaY)
		
			
			
func CheckIsClearingConnected(clearingA,clearingB):
	if clearingA.verbindingen.find(clearingB) != -1:
		return true
	else:
		return false
		

func GetUserInput(): #eventjes niet gebruikt, specifieker gemaakt naar 'ask for clearing'
	var UserInput = "hihi"
	var DidIGetInput = 0
	
	while DidIGetInput != 1:
		print("while loop")
		if Input.is_action_just_pressed("ui_1"):
			UserInput = "1"
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_2"):
			UserInput = "2"
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_3"):
			UserInput = "3"	
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_4"):
			UserInput = "4"
			DidIGetInput = 1
	
	return UserInput
			
func AskForClearing():
	var Clearing = $Clearing3
	var DidIGetInput = 0
	print("al tot hier1")
	
	while DidIGetInput != 1:
		print("al tot hier2")
		if Input.is_action_just_pressed("ui_1"):
			Clearing = $Clearing1
			DidIGetInput = 1
			print("al tot hier3")
		if Input.is_action_just_pressed("ui_2"):
			Clearing = $Clearing2
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_3"):
			Clearing = $Clearing3
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_4"):
			Clearing = $Clearing4
			DidIGetInput = 1
	return Clearing

	#var CurrentInputs = 0
	#while CurrentInputs<NumberOfInputs:


func _on_button_pressed():
	ApplyMoveBetweenClearings($Clearing2,$Clearing3)
	print("MIJNEN NIEUWEN KNOP")
	pass # Replace with function body.


func _on_button_pressed2():
	ApplyMoveBetweenClearings($Clearing3,$Clearing2)
	pass # Replace with function body.
