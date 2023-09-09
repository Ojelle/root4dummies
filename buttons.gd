extends Node2D


signal sig_recruit
signal sig_move
signal sig_buildGeklikt
signal sig_slideramountWarriors
var test = 0


func _ready():

	$Sliders.hide()
	Events.sig_WarriorsInClearing.connect(setMaxWarriorsSlider)
	Events.sig_ValidMoveEnded.connect(HideSlider)
	

func _process(delta):
	pass

func _on_recruit_pressed():
	sig_recruit.emit()


func _on_move_pressed():
	$Sliders.show()
	Events.sig_WarriorsInClearing
	sig_move.emit()
	


func _on_build_pressed():
	sig_buildGeklikt.emit()



func _on_h_slider_amount_warriors_drag_ended(value_changed):
	var amount = $Sliders/HSliderAmountWarriors.get_value()
	sig_slideramountWarriors.emit(amount)



func HideSlider():
	$Sliders.hide() #deze twee wil ik bij het klikken van de 2de (geldige)clearing
	$Sliders/HSliderAmountWarriors.value=0

func setMaxWarriorsSlider(max):
	$Sliders/HSliderAmountWarriors.max_value=max
	


func _on_h_slider_amount_warriors_value_changed(value):
	var Opschrift = " warriors"
	Opschrift = str($Sliders/HSliderAmountWarriors.value) + Opschrift
	$Sliders/LabelCurrentAmount.text=Opschrift



#	var deltaX = 5#ClearingB.global_position[0]-ClearingA.global_position[0]
#	$MarquiseDeCatWarrior3.move_local_x(deltaX)

