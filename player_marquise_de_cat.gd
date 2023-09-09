extends Node2D

signal sig_buildGekozen
signal sig_workshop
signal sig_recruiter


#var marquise = "A" #Gebruik Letter van Setup volgorde, of definieer ik setupvolgorde bij worldgen in 1x? 
var marquise = "marquise"
var sawmill = "sawmill"		#SAM - ik neem aan dat ik beter de kost en eventueel zelfs totaal aantal gebouwd opsla in var sawmill en alles ineens als array meegeef? 
var workshop = "workshop"
var recruiter = "recruiter"



func _ready():
	pass 



func _process(delta):
	pass


func _on_sawmill_pressed():
	sig_buildGekozen.emit(marquise,sawmill)
	

	#volgens mij heb ik de keuze tussen het volgende
	#Hier al 2 argumenten, player en building type, meegeven								-'beter' indien ik de knoppen de texture laat inladen op basis van welke speler aan zet is (moeilijker?)
	#afleiden op de plaats waar het signal geconnect wordt wat deze twee parameters zijn	-mogelijk indien ik voor elk type gebouw en elke speler een aparte set knopjes ed maak (meer werk?)


func _on_workshop_pressed():
	sig_buildGekozen.emit(marquise,workshop) 


func _on_recruiter_pressed():
	sig_buildGekozen.emit(marquise,recruiter) 
