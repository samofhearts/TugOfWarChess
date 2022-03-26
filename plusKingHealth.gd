extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_plusKingHealth_mouse_entered():
	self.get_node("btn1").hide()
	self.get_node("btn2").show()
	self.get_node("btn3").hide()


func _on_plusKingHealth_mouse_exited():
	self.get_node("btn1").show()
	self.get_node("btn2").hide()
	self.get_node("btn3").hide()


func _on_plusKingHealth_pressed():
	self.get_node("btn1").hide()
	self.get_node("btn2").hide()
	self.get_node("btn3").show()
	if GlobalVariables.whiteKingHealthUpgradeCost <= GlobalVariables.whiteMoney:
		GlobalVariables.whiteMoney -= GlobalVariables.whiteKingHealthUpgradeCost
		GlobalVariables.whiteKingsHealthNumber += 5
