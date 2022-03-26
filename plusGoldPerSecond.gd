extends Button

onready var mainScript = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_plusGoldPerSecond_mouse_entered():
	self.get_node("btn1").hide()
	self.get_node("btn2").show()
	self.get_node("btn3").hide()


func _on_plusGoldPerSecond_mouse_exited():
	self.get_node("btn1").show()
	self.get_node("btn2").hide()
	self.get_node("btn3").hide()


func _on_plusGoldPerSecond_pressed():
	self.get_node("btn1").hide()
	self.get_node("btn2").hide()
	self.get_node("btn3").show()
	if GlobalVariables.whiteGoldSpeedUpgradeCost <= GlobalVariables.whiteMoney:
		GlobalVariables.whiteMoney -= GlobalVariables.whiteGoldSpeedUpgradeCost
		GlobalVariables.whiteKingMoneyPerTimer += 1
