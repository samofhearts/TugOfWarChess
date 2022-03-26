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


func _on_startButton_pressed():
	self.get_node("start").hide()
	self.get_node("start2").hide()
	self.get_node("start3").show()
	yield(get_tree().create_timer(.1), "timeout")
	get_tree().change_scene("res://Main.tscn")



func _on_startButton_mouse_entered():
	self.get_node("start").hide()
	self.get_node("start2").show()
	self.get_node("start3").hide()


func _on_startButton_mouse_exited():
	self.get_node("start").show()
	self.get_node("start2").hide()
	self.get_node("start3").hide()
