extends Camera2D

## Vars
const cameraSpeed = 10
const scrollSpeed = 100

var vel : Vector2 = Vector2()

onready var mainScript = get_parent()

var full_screen = false






# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_pressed("camera_down") and self.position.y < -450:
		if full_screen == false:
			self.position += Vector2.DOWN * cameraSpeed
		
	elif Input.is_action_pressed("camera_up") and self.position.y > -1700:
		if full_screen == false:
			self.position += Vector2.UP * cameraSpeed
		
	if Input.is_action_just_released("zoom_out"):
		if full_screen == false:
			self.position += Vector2.DOWN * scrollSpeed
		
	elif Input.is_action_just_released("zoom_in"):
		if full_screen == false:
			self.position += Vector2.UP * scrollSpeed
		
	elif Input.is_action_just_released("full_map"):
		if full_screen == true:
			full_screen = false
			self.scale = Vector2(1,1)
			self.zoom.x = 1.2
			self.zoom.y = 1.2
			self.set_position(Vector2(525,-400))
			get_node("rightSideUI").set_position(Vector2(0,0))
			get_node("leftSideUI").set_position(Vector2(0,0))
		elif full_screen == false:
			full_screen = true
			self.scale = Vector2(2,2)
			self.zoom.x = 2.25
			self.zoom.y = 2.25
			self.set_position(Vector2(525,-1125))
			get_node("rightSideUI").set_position(Vector2(-300,100))
			get_node("leftSideUI").set_position(Vector2(200,0))
	
