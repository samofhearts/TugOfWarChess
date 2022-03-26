extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_plusGameSpeed_mouse_entered():
	self.get_node("btn1").hide()
	self.get_node("btn2").show()
	self.get_node("btn3").hide()


func _on_plusGameSpeed_mouse_exited():
	self.get_node("btn1").show()
	self.get_node("btn2").hide()
	self.get_node("btn3").hide()


func _on_plusGameSpeed_pressed():
	self.get_node("btn1").hide()
	self.get_node("btn2").hide()
	self.get_node("btn3").show()
	if GlobalVariables.whiteGameSpeedUpgradeCost <= GlobalVariables.whiteMoney:
		GlobalVariables.whiteMoney -= GlobalVariables.whiteGameSpeedUpgradeCost
		GlobalVariables.gameSpeed -= 0.1
