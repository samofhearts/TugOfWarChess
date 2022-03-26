extends Node2D


onready var mainScript = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(_delta):
	update()


##
##   DRAWWWWW
## 
func _draw():
	if !mainScript.drawListGreen.empty():
		for ob in mainScript.drawListGreen:
			var startPoint = Vector2(mainScript.drawListGreen[ob][0])
			var endPoint = Vector2(mainScript.drawListGreen[ob][1])
			var angle : int = rad2deg(startPoint.angle_to_point(endPoint))
			var arrowPointOne
			var arrowPointTwo
			if(angle == 135):				
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y + 5)
				arrowPointTwo = Vector2(endPoint.x - 5, endPoint.y + 20)
			elif(angle == 45):				
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y + 5)
				arrowPointTwo = Vector2(endPoint.x + 5, endPoint.y + 20)
				
				## KNIGHT RIGHT SHORT
			elif(angle == 116):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y + 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y + 25)
				
				## KNIGHT LEFT SHORT
			elif(angle == 63):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y + 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y + 25)
				
				## KNIGHT RIGHT LONG
			elif(angle == 153):
				arrowPointOne = Vector2(endPoint.x - 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x - 10, endPoint.y + 20)
				
				## KNIGHT LEFT LONG
			elif(angle == 26):
				arrowPointOne = Vector2(endPoint.x + 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x + 10, endPoint.y + 20)
				
				## ROOK LEFT
			elif(angle == 0):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y - 20)
				arrowPointTwo = Vector2(endPoint.x + 20, endPoint.y + 20)
				
				## ROOK RIGHT
			elif(angle == 180):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y - 20)
				arrowPointTwo = Vector2(endPoint.x - 20, endPoint.y + 20)
				
				## ROOK FORWARD
			elif(angle == 90):
				arrowPointOne = Vector2(endPoint.x - 15, endPoint.y + 20)
				arrowPointTwo = Vector2(endPoint.x + 15, endPoint.y + 20)
				
			else:
				arrowPointOne = Vector2(endPoint.x, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y)
			
			self.draw_line(to_local(startPoint),to_local(endPoint), Color(0,1,0, 1),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointOne), Color(0,1,0, 1),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointTwo), Color(0,1,0, 1),5)
			
	if !mainScript.drawListGreenMove.empty():
		for ob in mainScript.drawListGreenMove:
			var startPoint = Vector2(mainScript.drawListGreenMove[ob][0])
			var endPoint = Vector2(mainScript.drawListGreenMove[ob][1])
			var angle : int = rad2deg(startPoint.angle_to_point(endPoint))
			var arrowPointOne
			var arrowPointTwo
			if(angle == 135):				
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y + 5)
				arrowPointTwo = Vector2(endPoint.x - 5, endPoint.y + 20)
			elif(angle == 45):				
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y + 5)
				arrowPointTwo = Vector2(endPoint.x + 5, endPoint.y + 20)
				
				## KNIGHT RIGHT SHORT
			elif(angle == 116):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y + 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y + 25)
				
				## KNIGHT LEFT SHORT
			elif(angle == 63):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y + 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y + 25)
				
				## KNIGHT RIGHT LONG
			elif(angle == 153):
				arrowPointOne = Vector2(endPoint.x - 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x - 10, endPoint.y + 20)
				
				## KNIGHT LEFT LONG
			elif(angle == 26):
				arrowPointOne = Vector2(endPoint.x + 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x + 10, endPoint.y + 20)
				
				## ROOK LEFT
			elif(angle == 0):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y - 20)
				arrowPointTwo = Vector2(endPoint.x + 20, endPoint.y + 20)
				
				## ROOK RIGHT
			elif(angle == 180):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y - 20)
				arrowPointTwo = Vector2(endPoint.x - 20, endPoint.y + 20)
				
				## ROOK FORWARD
			elif(angle == 90):
				arrowPointOne = Vector2(endPoint.x - 15, endPoint.y + 20)
				arrowPointTwo = Vector2(endPoint.x + 15, endPoint.y + 20)
				
			else:
				arrowPointOne = Vector2(endPoint.x, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y)
			
			self.draw_line(to_local(startPoint),to_local(endPoint), Color(0,0,1, 0.5),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointOne), Color(0,0,1, 0.5),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointTwo), Color(0,0,1, 0.5),5)
			
	if !mainScript.drawListRed.empty():
		for ob in mainScript.drawListRed:
			var startPoint = Vector2(mainScript.drawListRed[ob][0])
			var endPoint = Vector2(mainScript.drawListRed[ob][1])
			var angle : int = rad2deg(startPoint.angle_to_point(endPoint))
			var arrowPointOne
			var arrowPointTwo
			if(angle == -135):				
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y - 5)
				arrowPointTwo = Vector2(endPoint.x - 5, endPoint.y - 20)
			elif(angle == -45):				
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y - 5)
				arrowPointTwo = Vector2(endPoint.x + 5, endPoint.y - 20)
				
				## KNIGHT RIGHT SHORT
			elif(angle == -116):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y - 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y - 25)
				
				## KNIGHT LEFT SHORT
			elif(angle == -63):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y - 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y - 25)
				
				## KNIGHT RIGHT LONG
			elif(angle == -153):
				arrowPointOne = Vector2(endPoint.x - 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x - 10, endPoint.y - 20)
				
				## KNIGHT LEFT LONG
			elif(angle == -26):
				arrowPointOne = Vector2(endPoint.x + 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x + 10, endPoint.y - 20)
				
				## ROOK LEFT
			elif(angle == 0):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y + 20)
				arrowPointTwo = Vector2(endPoint.x + 20, endPoint.y - 20)
				
				## ROOK RIGHT
			elif(angle == 180):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y + 20)
				arrowPointTwo = Vector2(endPoint.x - 20, endPoint.y - 20)
				
				## ROOK FORWARD
			elif(angle == -90):
				arrowPointOne = Vector2(endPoint.x - 15, endPoint.y - 20)
				arrowPointTwo = Vector2(endPoint.x + 15, endPoint.y - 20)
				
			else:
				arrowPointOne = Vector2(endPoint.x, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y)
			
			self.draw_line(to_local(startPoint),to_local(endPoint), Color(1,0,0, 1),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointOne), Color(1,0,0, 1),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointTwo), Color(1,0,0, 1),5)
			
	if !mainScript.drawListRedMove.empty():
		for ob in mainScript.drawListRedMove:
			var startPoint = Vector2(mainScript.drawListRedMove[ob][0])
			var endPoint = Vector2(mainScript.drawListRedMove[ob][1])
			var angle : int = rad2deg(startPoint.angle_to_point(endPoint))
			var arrowPointOne
			var arrowPointTwo
			if(angle == -135):				
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y - 5)
				arrowPointTwo = Vector2(endPoint.x - 5, endPoint.y - 20)
			elif(angle == -45):				
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y - 5)
				arrowPointTwo = Vector2(endPoint.x + 5, endPoint.y - 20)
				
				## KNIGHT RIGHT SHORT
			elif(angle == -116):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y - 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y - 25)
				
				## KNIGHT LEFT SHORT
			elif(angle == -63):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y - 15)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y - 25)
				
				## KNIGHT RIGHT LONG
			elif(angle == -153):
				arrowPointOne = Vector2(endPoint.x - 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x - 10, endPoint.y - 20)
				
				## KNIGHT LEFT LONG
			elif(angle == -26):
				arrowPointOne = Vector2(endPoint.x + 25, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x + 10, endPoint.y - 20)
				
				## ROOK LEFT
			elif(angle == 0):
				arrowPointOne = Vector2(endPoint.x + 20, endPoint.y + 20)
				arrowPointTwo = Vector2(endPoint.x + 20, endPoint.y - 20)
				
				## ROOK RIGHT
			elif(angle == 180):
				arrowPointOne = Vector2(endPoint.x - 20, endPoint.y + 20)
				arrowPointTwo = Vector2(endPoint.x - 20, endPoint.y - 20)
				
				## ROOK FORWARD
			elif(angle == -90):
				arrowPointOne = Vector2(endPoint.x - 15, endPoint.y - 20)
				arrowPointTwo = Vector2(endPoint.x + 15, endPoint.y - 20)
				
			else:
				arrowPointOne = Vector2(endPoint.x, endPoint.y)
				arrowPointTwo = Vector2(endPoint.x, endPoint.y)
			
			self.draw_line(to_local(startPoint),to_local(endPoint), Color(1,0,1, 0.5),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointOne), Color(1,0,1, 0.5),5)
			self.draw_line(to_local(endPoint),to_local(arrowPointTwo), Color(1,0,1, 0.5),5)
