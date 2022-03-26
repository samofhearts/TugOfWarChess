extends Node2D


## Pre-load Assets
var whitePawn = preload("res://whitePawn.tscn")
var whitePawnCursor = preload("res://Sprites/white_pawn_cursor.png")

var whiteKnight = preload("res://whiteKnight.tscn")
var whiteKnightCursor = preload("res://Sprites/white_knight_cursor.png")

var whiteBishop = preload("res://whiteBishop.tscn")
var whiteBishopCursor = preload("res://Sprites/white_bishop_cursor.png")

var whiteRook = preload("res://whiteRook.tscn")
var whiteRookCursor = preload("res://Sprites/white_rook_cursor.png")

var whiteQueen = preload("res://whiteQueen.tscn")
var whiteQueenCursor = preload("res://Sprites/white_queen_cursor.png")

var blackPawn = preload("res://blackPawn.tscn")
var blackKnight = preload("res://blackKnight.tscn")
var blackBishop = preload("res://blackBishop.tscn")
var blackRook = preload("res://blackRook.tscn")
var blackQueen = preload("res://blackQueen.tscn")

var deathAnim = preload("res://deathAnim.tscn")
var deathAnim2 = preload("res://deathAnim2.tscn")
var kill_sound = preload("res://kill_sound.tscn")
var kill_sound2 = preload("res://kill_sound2.tscn")

var step_sound = preload("res://step_sound.tscn")
var step_sound2 = preload("res://step_sound2.tscn")

## White Pieces Array
var whitePawnArray = []
var whiteKnightArray = []
var whiteBishopArray = []
var whiteRookArray = []
var whiteQueenArray = []

var whiteToBeRemoved = []

## Black Pieces Array
var blackPawnArray = []
var blackKnightArray = []
var blackBishopArray = []
var blackRookArray = []
var blackQueenArray = []

var blackToBeRemoved = []

## Timers
var gameTimer = Timer.new()

## Money
var moneyTimer = Timer.new()

## Turns
var whiteTurn : bool = true
var blackTurn : bool = false

## Radial Menu
var cursorIsWhitePawn : bool = false
var cursorIsWhiteKnight : bool = false
var cursorIsWhiteBishop : bool = false
var cursorIsWhiteRook : bool = false
var cursorIsWhiteQueen : bool = false
var cursorIsBlackPawn : bool = false
var cursorIsBlackKnight : bool = false
var cursorIsBlackBishop : bool = false
var cursorIsBlackRook : bool = false
var cursorIsBlackQueen : bool = false


## DRAW LIST
var drawListGreen = {}
var drawListGreenMove = {}
var drawListRed = {}
var drawListRedMove = {}


## RANDOM
var rng = RandomNumberGenerator.new()

## Health
var blackKingsHealthNumber : int = 100

## Possible Spawn Locations

var spawnLocations = ["a16","b16","c16","d16","e16","f16","g16","h16"]

## Possible Spawn Pieces

var spawnPiecesStrings = ["blackPawn","blackKnight","blackBishop","blackRook","blackQueen"]
var spawnPieces = [blackPawn,blackKnight,blackBishop,blackRook,blackQueen]
var spawnPiecesArrays = [blackPawnArray,blackKnightArray,blackBishopArray,blackRookArray,blackQueenArray]

##
## AI SPAWN UNITS
##
func ai_spawn_piece(ran_p,ran_loc):
	if can_afford(spawnPiecesStrings[ran_p]):
		var array = spawnPiecesArrays[ran_p]
		var p1 = spawnPieces[ran_p]
		var p2 = p1.instance()
		var loc = get_node(spawnLocations[ran_loc])
		var targetPosition = loc.get_position()
		var space_state = get_world_2d().direct_space_state
		var clearCheck = space_state.intersect_ray(Vector2(targetPosition.x - 75, targetPosition.y), Vector2(targetPosition.x + 75, targetPosition.y))
		if !clearCheck.empty():
			if clearCheck.collider.get_class() == "KinematicBody2D":
				pass
			else:
				p2.set_position(targetPosition)
				array.append(p2)
				add_child(p2)



##
## White Button Pressed
##
func white_button_pressed(loc):
	if cursorIsWhitePawn == true:
		if can_afford("whitePawn"):
			spawn_piece(whitePawn,loc,whitePawnArray)
		
	if cursorIsWhiteKnight == true:
		if can_afford("whiteKnight"):
			spawn_piece(whiteKnight,loc,whiteKnightArray)
		
	if cursorIsWhiteBishop == true:
		if can_afford("whiteBishop"):
			spawn_piece(whiteBishop,loc,whiteBishopArray)
		
	if cursorIsWhiteRook == true:
		if can_afford("whiteRook"):
			spawn_piece(whiteRook,loc,whiteRookArray)
		
	if cursorIsWhiteQueen == true:
		if can_afford("whiteQueen"):
			spawn_piece(whiteQueen,loc,whiteQueenArray)	

##
## CAN AFFORD CHEESEBURGER?
##
func can_afford(p):
	var canAfford = false
	if "whitePawn" == p:
		if GlobalVariables.whiteMoney >= 1:
			GlobalVariables.whiteMoney -= 1
			canAfford = true
	elif "whiteKnight" == p or "whiteBishop" == p:
		if GlobalVariables.whiteMoney >= 3:
			GlobalVariables.whiteMoney -= 3
			canAfford = true
	elif "whiteRook" == p:
		if GlobalVariables.whiteMoney >= 5:
			GlobalVariables.whiteMoney -= 5
			canAfford = true
	elif "whiteQueen" == p:
		if GlobalVariables.whiteMoney >= 9:
			GlobalVariables.whiteMoney -= 9
			canAfford = true
	elif "blackPawn" == p:
		if GlobalVariables.blackMoney >= 1:
			GlobalVariables.blackMoney -= 1
			canAfford = true
	elif "blackKnight" == p or "blackBishop" == p:
		if GlobalVariables.blackMoney >= 3:
			GlobalVariables.blackMoney -= 3
			canAfford = true
	elif "blackRook" == p:
		if GlobalVariables.blackMoney >= 5:
			GlobalVariables.blackMoney -= 5
			canAfford = true
	elif "blackQueen" == p:
		if GlobalVariables.blackMoney >= 9:
			GlobalVariables.blackMoney -= 9
			canAfford = true
	return canAfford	

##
## SPAWN UNITS
##
func spawn_piece(p,loc,pArray):
	var p2 = p.instance()
	var targetPosition = loc.get_position()
	var space_state = get_world_2d().direct_space_state
	var clearCheck = space_state.intersect_ray(Vector2(targetPosition.x - 75, targetPosition.y), Vector2(targetPosition.x + 75, targetPosition.y))
	if !clearCheck.empty():
		if clearCheck.collider.get_class() == "KinematicBody2D":
			pass
		else:
			p2.set_position(loc.get_position())
			pArray.append(p2)
			add_child(p2)


##
## Segment Cast (raycast multiple hits)
##
func segment_cast(piece):
	var space_state = get_world_2d().get_direct_space_state()
	var position = piece.get_position()

	var segment = SegmentShape2D.new()
	segment.set_a(Vector2(position.x - 75,position.y - 75))
	segment.set_b(Vector2(position.x + 75,position.y + 75))

	var query = Physics2DShapeQueryParameters.new()
	query.set_shape(segment)
	query.set_exclude([self]) # If you want to exclude the object casting the segment
	var hits = space_state.intersect_shape(query, 32)
	return hits


##
## Check Touchdown
##
func white_touchdown(piece):
	var spotCheck = segment_cast(piece)
	for n in range(0,spotCheck.size()):
		if "16" in spotCheck[n].collider.get_name():
			var damage = calc_damage(piece)
			blackKingsHealthNumber -= damage
			$mainCamera/rightSideUI/blackKingHealthNumber.bbcode_text = "[center]" + str(blackKingsHealthNumber) + "[/center]"
			whiteToBeRemoved.append(piece)
			remove_child(piece)	
			
func black_touchdown(piece):
	var spotCheck = segment_cast(piece)
	for n in range(0,spotCheck.size()):
		if "whiteEndzone" in spotCheck[n].collider.get_name():
			var damage = calc_damage(piece)
			GlobalVariables.whiteKingsHealthNumber -= damage
			$mainCamera/rightSideUI/whiteKingHealthNumber.bbcode_text = "[center]" + str(GlobalVariables.whiteKingsHealthNumber) + "[/center]"
			blackToBeRemoved.append(piece)
			remove_child(piece)	


##
## death Animation Finished
##
func deathAnimFinished(anim):
	remove_child(anim)
	
##
## kill Sound Finished
##
func kill_soundFinished(sound):
	remove_child(sound)

##
## Calculate Damage
##
func calc_damage(piece):
	var name = piece.get_name()
	if "Pawn" in name:
		return 2
	elif "Knight" in name:
		return 1
	elif "Bishop" in name:
		return 1
	elif "Rook" in name:
		return 1
	elif "Queen" in name:
		return 0
		
func name_to_array(piece):
	var name = piece.get_name()
	if "blackPawn" in name:
		return blackPawnArray
	elif "blackKnight" in name:
		return blackKnightArray
	elif "blackBishop" in name:
		return blackBishopArray
	elif "blackRook" in name:
		return blackRookArray
	elif "blackQueen" in name:
		return blackQueenArray
	elif "whitePawn" in name:
		return whitePawnArray
	elif "whiteKnight" in name:
		return whiteKnightArray
	elif "whiteBishop" in name:
		return whiteBishopArray
	elif "whiteRook" in name:
		return whiteRookArray
	elif "whiteQueen" in name:
		return whiteQueenArray
##
## WHITE ATTACK TO MOVE
##
func white_attack_to_move(results, piece):
	if !results.empty():
		var target = results.collider
		if target.get_class() == "KinematicBody2D":
			if "black" in target.get_name():
				
				## SFX
				var kill_sound2 = kill_sound.instance()
				add_child(kill_sound2)
				kill_sound2.connect("finished", self, "kill_soundFinished", [kill_sound2])
				kill_sound2.play()
				
				## DEATH ANIMATION
				var deathAnim2 = deathAnim.instance()
				add_child(deathAnim2)
				deathAnim2.set_position(target.get_position())
				deathAnim2.connect("animation_finished", self, "deathAnimFinished", [deathAnim2])
				deathAnim2.play()
				
				## JUICY BITS
				var array = name_to_array(target)
				drawListGreen[drawListGreen.size()] = [piece.get_position(),target.get_position()]
				piece.set_position(target.get_position())
				array.erase(target)
				remove_child(target)
				
				return true
			else:
				return false
		else:
			return false




##
## WHITE JUST MOVE
##
func white_just_move(results,piece):
	if !results.empty():
		var target = results.collider
		if target.get_class() == "StaticBody2D":
			## SFX
			var step_sound2 = step_sound.instance()
			add_child(step_sound2)
			step_sound2.connect("finished", self, "kill_soundFinished", [step_sound2])
			step_sound2.play()
			
			drawListGreenMove[drawListGreenMove.size()] = [piece.get_position(),target.get_position()]
				
			piece.set_position(target.get_position())
			return true
		else:
			return false
	else:
		return false
		
		
		
		
##
## BLACK ATTACK TO MOVE
##
func black_attack_to_move(results, piece):
	if !results.empty():
		var target = results.collider
		if target.get_class() == "KinematicBody2D":
			if "white" in target.get_name():
				
				## SFX
				var kill_sound3 = kill_sound2.instance()
				add_child(kill_sound3)
				kill_sound3.connect("finished", self, "kill_soundFinished", [kill_sound3])
				kill_sound3.play()
				
				## Death Animation
				var deathAnim3 = deathAnim2.instance()
				add_child(deathAnim3)
				deathAnim3.set_position(target.get_position())
				deathAnim3.connect("animation_finished", self, "deathAnimFinished", [deathAnim3])
				deathAnim3.play()
				
				## Juicy Bits
				var array = name_to_array(target)
				drawListRed[drawListRed.size()] = [piece.get_position(),target.get_position()]
				piece.set_position(target.get_position())
				array.erase(target)
				remove_child(target)
				return true
			else:
				return false
		else:
			return false
			
			
			
##
## BLACK JUST MOVE
##
func black_just_move(results,piece):
	if !results.empty():
		var target = results.collider
		if target.get_class() == "StaticBody2D":
			
			## SFX
			var step_sound3 = step_sound2.instance()
			add_child(step_sound3)
			step_sound3.connect("finished", self, "kill_soundFinished", [step_sound3])
			step_sound3.play()
			
			drawListRedMove[drawListRedMove.size()] = [piece.get_position(),target.get_position()]
			
			piece.set_position(target.get_position())
			return true
		else:
			return false
	else:
		return false
			
				
			
			
			
## Money Timer FUnction
func _moneyTimerHit():
	GlobalVariables.whiteMoney += GlobalVariables.whiteKingMoneyPerTimer
	GlobalVariables.blackMoney += GlobalVariables.blackKingMoneyPerTimer



## Game Timer Function
func _gameTimerHit():
	drawListGreen = {}
	drawListGreenMove = {}
	drawListRed = {}
	drawListRedMove = {}

####################################################################################################################################
####################################################################################################################################

									# WHITE TURN

####################################################################################################################################
####################################################################################################################################	
	
	if whiteTurn == true:
		
		##
		## Remove Pieces and Clean Up Arrays
		##
		
		for each in range(0,whiteToBeRemoved.size()):
			if "whitePawn" in whiteToBeRemoved[each].get_name():
				whitePawnArray.erase(whiteToBeRemoved[each])
			elif "whiteKnight" in whiteToBeRemoved[each].get_name():
				whiteKnightArray.erase(whiteToBeRemoved[each])
			elif "whiteBishop" in whiteToBeRemoved[each].get_name():
				whiteBishopArray.erase(whiteToBeRemoved[each])
			elif "whiteRook" in whiteToBeRemoved[each].get_name():
				whiteRookArray.erase(whiteToBeRemoved[each])
			elif "whiteQueen" in whiteToBeRemoved[each].get_name():
				whiteQueenArray.erase(whiteToBeRemoved[each])
				
		for each in range(0,blackToBeRemoved.size()):
			if "blackPawn" in blackToBeRemoved[each].get_name():
				blackPawnArray.erase(blackToBeRemoved[each])
			elif "blackKnight" in blackToBeRemoved[each].get_name():
				blackKnightArray.erase(blackToBeRemoved[each])
			elif "blackBishop" in blackToBeRemoved[each].get_name():
				blackBishopArray.erase(blackToBeRemoved[each])
			elif "blackRook" in blackToBeRemoved[each].get_name():
				blackRookArray.erase(blackToBeRemoved[each])
			elif "blackQueen" in blackToBeRemoved[each].get_name():
				blackQueenArray.erase(blackToBeRemoved[each])
		
		##
		## Move And Attack With White Pawns
		##
		for each in range(0,whitePawnArray.size()):
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			white_touchdown(whitePawnArray[each])
			
			var space_state = get_world_2d().direct_space_state
			var piece = whitePawnArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			
			## Check Space Left (Above and Left)
			if alreadyMoved == false:
				var result_up_left = space_state.intersect_ray(Vector2(piecePos.x - 75, piecePos.y - 75), Vector2(piecePos.x - 150, piecePos.y - 150), [piece])
				
				if white_attack_to_move(result_up_left, piece):
					alreadyMoved = true
					continue
					
			## Check Space Right (Above and Right)
			if alreadyMoved == false:
				var result_up_right = space_state.intersect_ray(Vector2(piecePos.x + 75, piecePos.y - 75), Vector2(piecePos.x + 150, piecePos.y - 150), [piece])
				
				if white_attack_to_move(result_up_right, piece):
					alreadyMoved = true
					continue
						
			## Check Space Forward (Above)
			if alreadyMoved == false:
				var result_forward = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y - 75), Vector2(piecePos.x, piecePos.y - 150), [piece])
				
				if white_just_move(result_forward, piece):
					alreadyMoved = true
					continue
					
		##
		## Move and Attack With White Knights
		##
		for each in range(0,whiteKnightArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = whiteKnightArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			white_touchdown(whiteKnightArray[each])
			
			###
			### ATTACKING
			###
			
			## Check Space (Left 2 Up 1)
			if alreadyMoved == false:
				var result_left_2_up_1 = space_state.intersect_ray(Vector2(piecePos.x - 225, piecePos.y - 75), Vector2(piecePos.x - 300, piecePos.y - 150), [piece])
				
				if alreadyMoved == false:
					if white_attack_to_move(result_left_2_up_1, piece):
						alreadyMoved = true
						continue
						
			## Check Space (Left 1 up 2)
			if alreadyMoved == false:
				var result_left_1_up_2 = space_state.intersect_ray(Vector2(piecePos.x - 75, piecePos.y - 225), Vector2(piecePos.x - 150, piecePos.y - 300), [piece])
				
				if alreadyMoved == false:
					if white_attack_to_move(result_left_1_up_2, piece):
						alreadyMoved = true
						continue
						
			## Check Space (right 1 up 2)
			if alreadyMoved == false:
				var result_right_1_up_2 = space_state.intersect_ray(Vector2(piecePos.x + 75, piecePos.y - 225), Vector2(piecePos.x + 150, piecePos.y - 300), [piece])
				
				if alreadyMoved == false:
					if white_attack_to_move(result_right_1_up_2, piece):
						alreadyMoved = true
						continue
						
			## Check Space (right 2 up 1)
			if alreadyMoved == false:
				var result_right_2_up_1 = space_state.intersect_ray(Vector2(piecePos.x + 225, piecePos.y - 75), Vector2(piecePos.x + 300, piecePos.y - 150), [piece])
				
				if alreadyMoved == false:
					if white_attack_to_move(result_right_2_up_1, piece):
						alreadyMoved = true
						continue
						
			###
			### MOVING
			###
			##
			## RANDOMIZE KNIGHT MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomKnight = []
			rng.randomize()
			
			
			## Check Space (Left 2 Up 1)
			if alreadyMoved == false:
				var result_left_2_up_1 = space_state.intersect_ray(Vector2(piecePos.x - 225, piecePos.y - 75), Vector2(piecePos.x - 300, piecePos.y - 150), [piece])
				if !result_left_2_up_1.empty():
					randomKnight.append(result_left_2_up_1)
							
				## Check Space (Left 1 up 2)
				var result_left_1_up_2 = space_state.intersect_ray(Vector2(piecePos.x - 75, piecePos.y - 225), Vector2(piecePos.x - 150, piecePos.y - 300), [piece])
				if !result_left_1_up_2.empty():
					randomKnight.append(result_left_1_up_2)
							
				## Check Space (right 1 up 2)
				var result_right_1_up_2 = space_state.intersect_ray(Vector2(piecePos.x + 75, piecePos.y - 225), Vector2(piecePos.x + 150, piecePos.y - 300), [piece])
				if !result_right_1_up_2.empty():
					randomKnight.append(result_right_1_up_2)
							
				## Check Space (right 2 up 1)
				var result_right_2_up_1 = space_state.intersect_ray(Vector2(piecePos.x + 225, piecePos.y - 75), Vector2(piecePos.x + 300, piecePos.y - 150), [piece])
				if !result_right_2_up_1.empty():
					randomKnight.append(result_right_2_up_1)
				
				if !randomKnight.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomKnight.size()-1)
					white_just_move(randomKnight[ranNum], piece)
						
						
		##
		## Move and Attack With White Bishops
		##
		for each in range(0,whiteBishopArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = whiteBishopArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			white_touchdown(whiteBishopArray[each])
			
			###
			### ATTACKING
			###
			var roadBlockLeft = false
			var roadBlockRight = false
			
			## Check Left Diag
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y - (n)), Vector2(piecePos.x - (n + 75), piecePos.y - (n + 75)), [piece])
				
					if alreadyMoved == false:
						if !result_left_diag.empty() and roadBlockLeft == false:
							if result_left_diag.collider.get_class() == "KinematicBody2D":
								if "white" in result_left_diag.collider.get_name():
									roadBlockLeft = true
									continue
								else:
									if white_attack_to_move(result_left_diag, piece):
										alreadyMoved = true
										continue
			
			
		## Check Right Diag
			if alreadyMoved == false:
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y - (n)), Vector2(piecePos.x + (n + 75), piecePos.y - (n + 75)), [piece])
				
					if alreadyMoved == false:
						if !result_right_diag.empty() and roadBlockRight == false:
							if result_right_diag.collider.get_class() == "KinematicBody2D":
								if "white" in result_right_diag.collider.get_name():
									roadBlockRight = true
									continue
								else:
									if white_attack_to_move(result_right_diag, piece):
										alreadyMoved = true
										continue
				
			###
			### MOVING
			###
			
			##
			## RANDOMIZE BISHOP MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomBishop = []
			rng.randomize()
			
			## Check Left Diag
			if alreadyMoved == false:
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y - (n)), Vector2(piecePos.x - (n + 75), piecePos.y - (n + 75)), [piece])
				
					if !result_left_diag_move.empty() and roadBlockLeft == false:
						if result_left_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeft = true
						else:
							randomBishop.append(result_left_diag_move)
				
				## Check Right Diag
			
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y - (n)), Vector2(piecePos.x + (n + 75), piecePos.y - (n + 75)), [piece])
				
					if !result_right_diag_move.empty() and roadBlockRight == false:
						if result_right_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockRight = true
						else:
							randomBishop.append(result_right_diag_move)
							
				if !randomBishop.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomBishop.size()-1)
					if white_just_move(randomBishop[ranNum], piece):
						continue
					
					
		##
		## Move and Attack With White Rooks
		##		
		for each in range(0,whiteRookArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = whiteRookArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false	
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			white_touchdown(whiteRookArray[each])			
						
			###
			### ATTACKING
			###
			var roadBlockLeftRook = false
			var roadBlockRightRook = false
			var roadBlockForwardRook = false
			
			## Check LEFT
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_rook = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_left_rook.empty() and roadBlockLeftRook == false:
							if result_left_rook.collider.get_class() == "KinematicBody2D":
								if "white" in result_left_rook.collider.get_name():
									roadBlockLeftRook = true
									continue
								else:
									if white_attack_to_move(result_left_rook, piece):
										alreadyMoved = true
										continue			
				
			## Check RIGHT
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_right_rook = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_right_rook.empty() and roadBlockRightRook == false:
							if result_right_rook.collider.get_class() == "KinematicBody2D":
								if "white" in result_right_rook.collider.get_name():
									roadBlockRightRook = true
									continue
								else:
									if white_attack_to_move(result_right_rook, piece):
										alreadyMoved = true
										continue		
					
			## Check FORWARD
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_forward_rook = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y - (n)), Vector2(piecePos.x, piecePos.y - (75 + n)), [piece])
					
					if alreadyMoved == false:
						if !result_forward_rook.empty() and roadBlockForwardRook == false:
							if result_forward_rook.collider.get_class() == "KinematicBody2D":
								if "white" in result_forward_rook.collider.get_name():
									roadBlockForwardRook = true
									continue
								else:
									if white_attack_to_move(result_forward_rook, piece):
										alreadyMoved = true
										continue		
					
					
##
			## RANDOMIZE ROOK MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomRook = []
			rng.randomize()
			
			## Check Left
			if alreadyMoved == false:
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_rook_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
				
					if !result_left_rook_move.empty() and roadBlockLeftRook == false:
						if result_left_rook_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeftRook = true
						else:
							randomRook.append(result_left_rook_move)
				
				## Check Right
				
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_rook_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
				
					if !result_right_rook_move.empty() and roadBlockRightRook == false:
						if result_right_rook_move.collider.get_class() == "KinematicBody2D":
							roadBlockRightRook = true
						else:
							randomRook.append(result_right_rook_move)
							
				## Check Forward
				
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_forward_rook_move = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y - (n)), Vector2(piecePos.x, piecePos.y - (n + 75)), [piece])
				
					if !result_forward_rook_move.empty() and roadBlockForwardRook == false:
						if result_forward_rook_move.collider.get_class() == "KinematicBody2D":
							roadBlockForwardRook = true
						else:
							randomRook.append(result_forward_rook_move)
			
					
				if !randomRook.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomRook.size()-1)
					if white_just_move(randomRook[ranNum], piece):
						continue
					
					
		##
		## Move and Attack With White Queens
		##		
		for each in range(0,whiteQueenArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = whiteQueenArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			white_touchdown(whiteQueenArray[each])
					
			###
			### ATTACKING
			###
			var roadBlockLeftQueen = false
			var roadBlockLeftDiagQueen = false
			var roadBlockRightQueen = false
			var roadBlockRightDiagQueen = false
			var roadBlockForwardQueen = false
			
			## Check Left Diag
			if alreadyMoved == false:	
				for i in range(1,GlobalVariables.whiteQueenRange):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag_queen = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y - (n)), Vector2(piecePos.x - (n + 75), piecePos.y - (n + 75)), [piece])
					
					if alreadyMoved == false:
						if !result_left_diag_queen.empty() and roadBlockLeftDiagQueen == false:
							if result_left_diag_queen.collider.get_class() == "KinematicBody2D":
								if "white" in result_left_diag_queen.collider.get_name():
									roadBlockLeftDiagQueen = true
									continue
								else:
									if white_attack_to_move(result_left_diag_queen, piece):
										alreadyMoved = true
										continue
					
		## Check Right Diag
			if alreadyMoved == false:
				for i in range(1,GlobalVariables.whiteQueenRange):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag_queen = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y - (n)), Vector2(piecePos.x + (n + 75), piecePos.y - (n + 75)), [piece])
					
					if alreadyMoved == false:
						if !result_right_diag_queen.empty() and roadBlockRightDiagQueen == false:
							if result_right_diag_queen.collider.get_class() == "KinematicBody2D":
								if "white" in result_right_diag_queen.collider.get_name():
									roadBlockRightDiagQueen = true
									continue
								else:
									if white_attack_to_move(result_right_diag_queen, piece):
										alreadyMoved = true
										continue	
					
			## Check LEFT
			if alreadyMoved == false:	
				for i in range(1,GlobalVariables.whiteQueenRange):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_queen = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_left_queen.empty() and roadBlockLeftQueen == false:
							if result_left_queen.collider.get_class() == "KinematicBody2D":
								if "white" in result_left_queen.collider.get_name():
									roadBlockLeftQueen = true
									continue
								else:
									if white_attack_to_move(result_left_queen, piece):
										alreadyMoved = true
										continue
					
			## Check RIGHT
			if alreadyMoved == false:	
				for i in range(1,GlobalVariables.whiteQueenRange):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_right_queen = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_right_queen.empty() and roadBlockRightQueen == false:
							if result_right_queen.collider.get_class() == "KinematicBody2D":
								if "white" in result_right_queen.collider.get_name():
									roadBlockRightQueen = true
									continue
								else:
									if white_attack_to_move(result_right_queen, piece):
										alreadyMoved = true
										continue		
					
			## Check FORWARD
			if alreadyMoved == false:	
				for i in range(1,GlobalVariables.whiteQueenRange):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_forward_queen = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y - (n)), Vector2(piecePos.x, piecePos.y - (75 + n)), [piece])
				
					if alreadyMoved == false:
						if !result_forward_queen.empty() and roadBlockForwardQueen == false:
							if result_forward_queen.collider.get_class() == "KinematicBody2D":
								if "white" in result_forward_queen.collider.get_name():
									roadBlockForwardQueen = true
									continue
								else:
									if white_attack_to_move(result_forward_queen, piece):
										alreadyMoved = true
										continue				
						
## RANDOMIZE Queen MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomQueen = []
			rng.randomize()
			
			## Check Left
			if alreadyMoved == false:
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_queen_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
				
					if !result_left_queen_move.empty() and roadBlockLeftQueen == false:
						if result_left_queen_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeftQueen = true
						else:
							randomQueen.append(result_left_queen_move)
							
				## Check Right
				
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_queen_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
				
					if !result_right_queen_move.empty() and roadBlockRightQueen == false:
						if result_right_queen_move.collider.get_class() == "KinematicBody2D":
							roadBlockRightQueen = true
						else:
							randomQueen.append(result_right_queen_move)
							
				## Check Forward
				
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_forward_queen_move = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y - (n)), Vector2(piecePos.x, piecePos.y - (n + 75)), [piece])
				
					if !result_forward_queen_move.empty() and roadBlockForwardQueen == false:
						if result_forward_queen_move.collider.get_class() == "KinematicBody2D":
							roadBlockForwardQueen = true
						else:
							randomQueen.append(result_forward_queen_move)
							
				## Check Left Diag
				
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y - (n)), Vector2(piecePos.x - (n + 75), piecePos.y - (n + 75)), [piece])
				
					if !result_left_diag_move.empty() and roadBlockLeftDiagQueen == false:
						if result_left_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeftDiagQueen = true
						else:
							randomQueen.append(result_left_diag_move)
				
				## Check Right Diag
			
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y - (n)), Vector2(piecePos.x + (n + 75), piecePos.y - (n + 75)), [piece])
				
					if !result_right_diag_move.empty() and roadBlockRightDiagQueen == false:
						if result_right_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockRightDiagQueen = true
						else:
							randomQueen.append(result_right_diag_move)
							
							
				if !randomQueen.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomQueen.size()-1)
					if white_just_move(randomQueen[ranNum], piece):
						continue
						
						
####################################################################################################################################
####################################################################################################################################

									# BLACK TURN

####################################################################################################################################
####################################################################################################################################
						
						
						
						
				
				
	elif blackTurn == true:
		##
		## Move And Attack With Black Pawns
		##
		for each in range(0,blackPawnArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = blackPawnArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			black_touchdown(piece)
			
			## Check Space Left (Below and Left)
			if alreadyMoved == false:
				var result_below_left = space_state.intersect_ray(Vector2(piecePos.x - 75, piecePos.y + 75), Vector2(piecePos.x - 150, piecePos.y + 150), [piece])
				
				if alreadyMoved == false:
					if black_attack_to_move(result_below_left, piece):
						alreadyMoved = true
						continue
					
			## Check Space Right (Below and Right)
			if alreadyMoved == false:
				var result_below_right = space_state.intersect_ray(Vector2(piecePos.x + 75, piecePos.y + 75), Vector2(piecePos.x + 150, piecePos.y + 150), [piece])
				
				if alreadyMoved == false:
					if black_attack_to_move(result_below_right, piece):
						alreadyMoved = true
						continue
			
			## Check Space Forward (Below)
			if alreadyMoved == false:
				var result_forward = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y + 75), Vector2(piecePos.x, piecePos.y + 150), [piece])
				
				if alreadyMoved == false:
					if black_just_move(result_forward, piece):
						alreadyMoved = true
						continue
					
					
		##
		## Move and Attack With Black Knights
		##
		for each in range(0,blackKnightArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = blackKnightArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			black_touchdown(piece)
			
			###
			### ATTACKING
			###
			
			## Check Space (Left 2 down 1)
			if alreadyMoved == false:
				var result_left_2_down_1 = space_state.intersect_ray(Vector2(piecePos.x - 225, piecePos.y + 75), Vector2(piecePos.x - 300, piecePos.y + 150), [piece])
				
				if alreadyMoved == false:
					if black_attack_to_move(result_left_2_down_1, piece):
						alreadyMoved = true
						continue
						
			## Check Space (Left 1 down 2)
			if alreadyMoved == false:
				var result_left_1_down_2 = space_state.intersect_ray(Vector2(piecePos.x - 75, piecePos.y + 225), Vector2(piecePos.x - 150, piecePos.y + 300), [piece])
				
				if alreadyMoved == false:
					if black_attack_to_move(result_left_1_down_2, piece):
						alreadyMoved = true
						continue
						
			## Check Space (right 1 down 2)
			if alreadyMoved == false:
				var result_right_1_down_2 = space_state.intersect_ray(Vector2(piecePos.x + 75, piecePos.y + 225), Vector2(piecePos.x + 150, piecePos.y + 300), [piece])
				
				if alreadyMoved == false:
					if black_attack_to_move(result_right_1_down_2, piece):
						alreadyMoved = true
						continue
						
			## Check Space (right 2 down 1)
			if alreadyMoved == false:
				var result_right_2_down_1 = space_state.intersect_ray(Vector2(piecePos.x + 225, piecePos.y + 75), Vector2(piecePos.x + 300, piecePos.y + 150), [piece])
				
				if alreadyMoved == false:
					if black_attack_to_move(result_right_2_down_1, piece):
						alreadyMoved = true
						continue
						
			###
			### MOVING
			###
			##
			## RANDOMIZE KNIGHT MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomKnight = []
			rng.randomize()
			
			
			## Check Space (Left 2 down 1)
			if alreadyMoved == false:
				var result_left_2_down_1 = space_state.intersect_ray(Vector2(piecePos.x - 225, piecePos.y + 75), Vector2(piecePos.x - 300, piecePos.y + 150), [piece])
				if !result_left_2_down_1.empty():
					randomKnight.append(result_left_2_down_1)
							
				## Check Space (Left 1 down 2)
				var result_left_1_down_2 = space_state.intersect_ray(Vector2(piecePos.x - 75, piecePos.y + 225), Vector2(piecePos.x - 150, piecePos.y + 300), [piece])
				if !result_left_1_down_2.empty():
					randomKnight.append(result_left_1_down_2)
							
				## Check Space (right 1 down 2)
				var result_right_1_down_2 = space_state.intersect_ray(Vector2(piecePos.x + 75, piecePos.y + 225), Vector2(piecePos.x + 150, piecePos.y + 300), [piece])
				if !result_right_1_down_2.empty():
					randomKnight.append(result_right_1_down_2)
							
				## Check Space (right 2 down 1)
				var result_right_2_down_1 = space_state.intersect_ray(Vector2(piecePos.x + 225, piecePos.y + 75), Vector2(piecePos.x + 300, piecePos.y + 150), [piece])
				if !result_right_2_down_1.empty():
					randomKnight.append(result_right_2_down_1)
				
				if !randomKnight.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomKnight.size()-1)
					black_just_move(randomKnight[ranNum], piece)
				
				
		##
		## Move and Attack With Black Bishops
		##
		for each in range(0,blackBishopArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = blackBishopArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			black_touchdown(piece)
			
			###
			### ATTACKING
			###
			var roadBlockLeft = false
			var roadBlockRight = false
			
			## Check Left Diag
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y + (n)), Vector2(piecePos.x - (n + 75), piecePos.y + (n + 75)), [piece])
				
					if alreadyMoved == false:
						if !result_left_diag.empty() and roadBlockLeft == false:
							if result_left_diag.collider.get_class() == "KinematicBody2D":
								if "black" in result_left_diag.collider.get_name():
									roadBlockLeft = true
									continue
								else:
									if black_attack_to_move(result_left_diag, piece):
										alreadyMoved = true
										continue
			
			
		## Check Right Diag
			if alreadyMoved == false:
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y + (n)), Vector2(piecePos.x + (n + 75), piecePos.y + (n + 75)), [piece])
				
					if alreadyMoved == false:
						if !result_right_diag.empty() and roadBlockRight == false:
							if result_right_diag.collider.get_class() == "KinematicBody2D":
								if "black" in result_right_diag.collider.get_name():
									roadBlockRight = true
									continue
								else:
									if black_attack_to_move(result_right_diag, piece):
										alreadyMoved = true
										continue
				
			###
			### MOVING
			###
			
			##
			## RANDOMIZE BISHOP MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomBishop = []
			rng.randomize()
			
			## Check Left Diag
			if alreadyMoved == false:
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y + (n)), Vector2(piecePos.x - (n + 75), piecePos.y + (n + 75)), [piece])
				
					if !result_left_diag_move.empty() and roadBlockLeft == false:
						if result_left_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeft = true
						else:
							randomBishop.append(result_left_diag_move)
				
				## Check Right Diag
			
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y + (n)), Vector2(piecePos.x + (n + 75), piecePos.y + (n + 75)), [piece])
				
					if !result_right_diag_move.empty() and roadBlockRight == false:
						if result_right_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockRight = true
						else:
							randomBishop.append(result_right_diag_move)
							
				if !randomBishop.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomBishop.size()-1)
					if black_just_move(randomBishop[ranNum], piece):
						continue
						


		##
		## Move and Attack With Black Rooks
		##		
		for each in range(0,blackRookArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = blackRookArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false	
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			black_touchdown(piece)			
						
			###
			### ATTACKING
			###
			var roadBlockLeftRook = false
			var roadBlockRightRook = false
			var roadBlockForwardRook = false
			
			## Check LEFT
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_rook = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_left_rook.empty() and roadBlockLeftRook == false:
							if result_left_rook.collider.get_class() == "KinematicBody2D":
								if "black" in result_left_rook.collider.get_name():
									roadBlockLeftRook = true
									continue
								else:
									if black_attack_to_move(result_left_rook, piece):
										alreadyMoved = true
										continue			
				
			## Check RIGHT
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_right_rook = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_right_rook.empty() and roadBlockRightRook == false:
							if result_right_rook.collider.get_class() == "KinematicBody2D":
								if "black" in result_right_rook.collider.get_name():
									roadBlockRightRook = true
									continue
								else:
									if black_attack_to_move(result_right_rook, piece):
										alreadyMoved = true
										continue		
					
			## Check FORWARD
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_forward_rook = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y + (n)), Vector2(piecePos.x, piecePos.y + (75 + n)), [piece])
					
					if alreadyMoved == false:
						if !result_forward_rook.empty() and roadBlockForwardRook == false:
							if result_forward_rook.collider.get_class() == "KinematicBody2D":
								if "black" in result_forward_rook.collider.get_name():
									roadBlockForwardRook = true
									continue
								else:
									if black_attack_to_move(result_forward_rook, piece):
										alreadyMoved = true
										continue		
					
					
##
			## RANDOMIZE ROOK MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomRook = []
			rng.randomize()
			
			## Check Left
			if alreadyMoved == false:
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_rook_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
				
					if !result_left_rook_move.empty() and roadBlockLeftRook == false:
						if result_left_rook_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeftRook = true
						else:
							randomRook.append(result_left_rook_move)
				
				## Check Right
				
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_rook_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
				
					if !result_right_rook_move.empty() and roadBlockRightRook == false:
						if result_right_rook_move.collider.get_class() == "KinematicBody2D":
							roadBlockRightRook = true
						else:
							randomRook.append(result_right_rook_move)
							
				## Check Forward
				
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_forward_rook_move = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y + (n)), Vector2(piecePos.x, piecePos.y + (n + 75)), [piece])
				
					if !result_forward_rook_move.empty() and roadBlockForwardRook == false:
						if result_forward_rook_move.collider.get_class() == "KinematicBody2D":
							roadBlockForwardRook = true
						else:
							randomRook.append(result_forward_rook_move)
			
					
				if !randomRook.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomRook.size()-1)
					if black_just_move(randomRook[ranNum], piece):
						continue
						
		##
		## Move and Attack With black Queens
		##		
		for each in range(0,blackQueenArray.size()):
			var space_state = get_world_2d().direct_space_state
			var piece = blackQueenArray[each]
			var piecePos = piece.get_position()
			var alreadyMoved = false
			yield(get_tree().create_timer(.02), "timeout")
			
			## Deal Damage If Possible
			black_touchdown(piece)
					
			###
			### ATTACKING
			###
			
			var roadBlockLeftQueen = false
			var roadBlockLeftDiagQueen = false
			var roadBlockRightQueen = false
			var roadBlockRightDiagQueen = false
			var roadBlockForwardQueen = false
			
			## Check Left Diag
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag_queen = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y + (n)), Vector2(piecePos.x - (n + 75), piecePos.y + (n + 75)), [piece])
					
					if alreadyMoved == false:
						if !result_left_diag_queen.empty() and roadBlockLeftDiagQueen == false:
							if result_left_diag_queen.collider.get_class() == "KinematicBody2D":
								if "black" in result_left_diag_queen.collider.get_name():
									roadBlockLeftDiagQueen = true
									continue
								else:
									if black_attack_to_move(result_left_diag_queen, piece):
										alreadyMoved = true
										continue
					
		## Check Right Diag
			if alreadyMoved == false:
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag_queen = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y + (n)), Vector2(piecePos.x + (n + 75), piecePos.y + (n + 75)), [piece])
					
					if alreadyMoved == false:
						if !result_right_diag_queen.empty() and roadBlockRightDiagQueen == false:
							if result_right_diag_queen.collider.get_class() == "KinematicBody2D":
								if "black" in result_right_diag_queen.collider.get_name():
									roadBlockRightDiagQueen = true
									continue
								else:
									if black_attack_to_move(result_right_diag_queen, piece):
										alreadyMoved = true
										continue	
					
			## Check LEFT
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_queen = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_left_queen.empty() and roadBlockLeftQueen == false:
							if result_left_queen.collider.get_class() == "KinematicBody2D":
								if "black" in result_left_queen.collider.get_name():
									roadBlockLeftQueen = true
									continue
								else:
									if black_attack_to_move(result_left_queen, piece):
										alreadyMoved = true
										continue
					
			## Check RIGHT
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_right_queen = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
					
					if alreadyMoved == false:
						if !result_right_queen.empty() and roadBlockRightQueen == false:
							if result_right_queen.collider.get_class() == "KinematicBody2D":
								if "black" in result_right_queen.collider.get_name():
									roadBlockRightQueen = true
									continue
								else:
									if black_attack_to_move(result_right_queen, piece):
										alreadyMoved = true
										continue		
					
			## Check FORWARD
			if alreadyMoved == false:	
				for i in range(1,4):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
							
					var result_forward_queen = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y + (n)), Vector2(piecePos.x, piecePos.y + (75 + n)), [piece])
				
					if alreadyMoved == false:
						if !result_forward_queen.empty() and roadBlockForwardQueen == false:
							if result_forward_queen.collider.get_class() == "KinematicBody2D":
								if "black" in result_forward_queen.collider.get_name():
									roadBlockForwardQueen = true
									continue
								else:
									if black_attack_to_move(result_forward_queen, piece):
										alreadyMoved = true
										continue				
						
## RANDOMIZE Queen MOVES IF THERE IS NO ATTACK OPPORTUNITY
			##
			var randomQueen = []
			rng.randomize()
			
			## Check Left
			if alreadyMoved == false:
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_queen_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y), Vector2(piecePos.x - (n + 75), piecePos.y), [piece])
				
					if !result_left_queen_move.empty() and roadBlockLeftQueen == false:
						if result_left_queen_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeftQueen = true
						else:
							randomQueen.append(result_left_queen_move)
							
				## Check Right
				
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_queen_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y), Vector2(piecePos.x + (n + 75), piecePos.y), [piece])
				
					if !result_right_queen_move.empty() and roadBlockRightQueen == false:
						if result_right_queen_move.collider.get_class() == "KinematicBody2D":
							roadBlockRightQueen = true
						else:
							randomQueen.append(result_right_queen_move)
							
				## Check Forward
				
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_forward_queen_move = space_state.intersect_ray(Vector2(piecePos.x, piecePos.y + (n)), Vector2(piecePos.x, piecePos.y + (n + 75)), [piece])
				
					if !result_forward_queen_move.empty() and roadBlockForwardQueen == false:
						if result_forward_queen_move.collider.get_class() == "KinematicBody2D":
							roadBlockForwardQueen = true
						else:
							randomQueen.append(result_forward_queen_move)
							
				## Check Left Diag
				
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_left_diag_move = space_state.intersect_ray(Vector2(piecePos.x - (n), piecePos.y + (n)), Vector2(piecePos.x - (n + 75), piecePos.y + (n + 75)), [piece])
				
					if !result_left_diag_move.empty() and roadBlockLeftDiagQueen == false:
						if result_left_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockLeftDiagQueen = true
						else:
							randomQueen.append(result_left_diag_move)
				
				## Check Right Diag
			
				for i in range(1,2):
					var n = 0
					if i == 1:
						n = 75
					else:
						n = (75 + (150 * (i-1)))
						
					var result_right_diag_move = space_state.intersect_ray(Vector2(piecePos.x + (n), piecePos.y + (n)), Vector2(piecePos.x + (n + 75), piecePos.y + (n + 75)), [piece])
				
					if !result_right_diag_move.empty() and roadBlockRightDiagQueen == false:
						if result_right_diag_move.collider.get_class() == "KinematicBody2D":
							roadBlockRightDiagQueen = true
						else:
							randomQueen.append(result_right_diag_move)
							
							
				if !randomQueen.empty():
					rng.randomize()
					var ranNum = rng.randi_range(0,randomQueen.size()-1)
					if black_just_move(randomQueen[ranNum], piece):
						continue
					
					
					
					
					
					
					
					
	if whiteTurn == true:
		whiteTurn = false
		blackTurn = true
	elif blackTurn == true:
		blackTurn = false
		whiteTurn = true
		







# Called when the node enters the scene tree for the first time.
func _ready():
	gameTimer.set_wait_time(GlobalVariables.gameSpeed)
	gameTimer.set_one_shot(false)
	gameTimer.set_paused(false)
	gameTimer.connect("timeout", self, "_gameTimerHit")
	gameTimer.set_autostart(true)
	add_child(gameTimer)
	
	moneyTimer.set_wait_time(GlobalVariables.moneySpeed)
	moneyTimer.set_one_shot(false)
	moneyTimer.set_paused(false)
	moneyTimer.connect("timeout", self, "_moneyTimerHit")
	moneyTimer.set_autostart(true)
	add_child(moneyTimer)
	
	$mainCamera/rightSideUI/whiteMoneyNumber.bbcode_text = "[right]" + str(GlobalVariables.whiteMoney) + "[/right]"
	$mainCamera/rightSideUI/blackMoneyNumber.bbcode_text = "[right]" + str(GlobalVariables.blackMoney) + "[/right]"
	
	

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("cancel_selection"):
		Input.set_custom_mouse_cursor(null)
		cursorIsWhitePawn = false
		cursorIsWhiteKnight = false
		cursorIsWhiteBishop = false
		cursorIsWhiteRook = false
		cursorIsWhiteQueen = false
		cursorIsBlackPawn = false
		cursorIsBlackKnight = false
		cursorIsBlackBishop = false
		cursorIsBlackRook = false
		cursorIsBlackQueen = false
		
	$mainCamera/rightSideUI/whiteMoneyNumber.bbcode_text = "[right]" + str(GlobalVariables.whiteMoney) + "[/right]"
	$mainCamera/rightSideUI/blackMoneyNumber.bbcode_text = "[right]" + str(GlobalVariables.blackMoney) + "[/right]"
	$mainCamera/rightSideUI/whiteKingHealthNumber.bbcode_text = "[center]" + str(GlobalVariables.whiteKingsHealthNumber) + "[/center]"

## WHITE SIDE BUTTON PRESSES

func _on_a1Btn_pressed():
	white_button_pressed($a1)
	
func _on_b1Btn_pressed():
	white_button_pressed($b1)

func _on_c1Btn_pressed():
	white_button_pressed($c1)

func _on_d1Btn_pressed():
	white_button_pressed($d1)

func _on_e1Btn_pressed():
	white_button_pressed($e1)

func _on_f1Btn_pressed():
	white_button_pressed($f1)

func _on_g1Btn_pressed():
	white_button_pressed($g1)

func _on_h1Btn_pressed():
	white_button_pressed($h1)
	

### BLACK SIDE BUTTONS
#
#func _on_a16Btn_pressed():
#	var blackPawn2 = blackPawn.instance()
#	blackPawn2.set_position($a16.get_position())
#	blackPawnArray.append(blackPawn2)
#	add_child(blackPawn2)
#
#func _on_b16Btn_pressed():
#	var blackPawn2 = blackPawn.instance()
#	blackPawn2.set_position($b16.get_position())
#	blackPawnArray.append(blackPawn2)
#	add_child(blackPawn2)
#
#func _on_c16Btn_pressed():
#	var blackPawn2 = blackPawn.instance()
#	blackPawn2.set_position($c16.get_position())
#	blackPawnArray.append(blackPawn2)
#	add_child(blackPawn2)
#
#func _on_d16Btn_pressed():
#	var blackPawn2 = blackPawn.instance()
#	blackPawn2.set_position($d16.get_position())
#	blackPawnArray.append(blackPawn2)
#	add_child(blackPawn2)
#
#func _on_e16Btn_pressed():
#	var blackPawn2 = blackPawn.instance()
#	blackPawn2.set_position($e16.get_position())
#	blackPawnArray.append(blackPawn2)
#	add_child(blackPawn2)
#
#func _on_f16Btn_pressed():
#	var blackPawn2 = blackPawn.instance()
#	blackPawn2.set_position($f16.get_position())
#	blackPawnArray.append(blackPawn2)
#	add_child(blackPawn2)
#
#func _on_g16Btn_pressed():
#	var blackPawn2 = blackPawn.instance()
#	blackPawn2.set_position($g16.get_position())
#	blackPawnArray.append(blackPawn2)
#	add_child(blackPawn2)
#
#func _on_h16Btn_pressed():
	var blackPawn2 = blackPawn.instance()
	blackPawn2.set_position($h16.get_position())
	blackPawnArray.append(blackPawn2)
	add_child(blackPawn2)
	




func _on_whitePawnChooser_pressed():
	cursorIsWhitePawn = false
	cursorIsWhiteKnight = false
	cursorIsWhiteBishop = false
	cursorIsWhiteRook = false
	cursorIsWhiteQueen = false
	cursorIsBlackPawn = false
	cursorIsBlackKnight = false
	cursorIsBlackBishop = false
	cursorIsBlackRook = false
	cursorIsBlackQueen = false
	cursorIsWhitePawn = true
	Input.set_custom_mouse_cursor(whitePawnCursor, 0, Vector2(50,50))


func _on_whiteKnightChooser_pressed():
	cursorIsWhitePawn = false
	cursorIsWhiteKnight = false
	cursorIsWhiteBishop = false
	cursorIsWhiteRook = false
	cursorIsWhiteQueen = false
	cursorIsBlackPawn = false
	cursorIsBlackKnight = false
	cursorIsBlackBishop = false
	cursorIsBlackRook = false
	cursorIsBlackQueen = false
	cursorIsWhiteKnight = true
	Input.set_custom_mouse_cursor(whiteKnightCursor, 0, Vector2(50,50))


func _on_whiteBishopChooser_pressed():
	cursorIsWhitePawn = false
	cursorIsWhiteKnight = false
	cursorIsWhiteBishop = false
	cursorIsWhiteRook = false
	cursorIsWhiteQueen = false
	cursorIsBlackPawn = false
	cursorIsBlackKnight = false
	cursorIsBlackBishop = false
	cursorIsBlackRook = false
	cursorIsBlackQueen = false
	cursorIsWhiteBishop = true
	Input.set_custom_mouse_cursor(whiteBishopCursor, 0, Vector2(50,50))


func _on_whiteRookChooser_pressed():
	cursorIsWhitePawn = false
	cursorIsWhiteKnight = false
	cursorIsWhiteBishop = false
	cursorIsWhiteRook = false
	cursorIsWhiteQueen = false
	cursorIsBlackPawn = false
	cursorIsBlackKnight = false
	cursorIsBlackBishop = false
	cursorIsBlackRook = false
	cursorIsBlackQueen = false
	cursorIsWhiteRook = true
	Input.set_custom_mouse_cursor(whiteRookCursor, 0, Vector2(50,50))


func _on_whiteQueenChooser_pressed():
	cursorIsWhitePawn = false
	cursorIsWhiteKnight = false
	cursorIsWhiteBishop = false
	cursorIsWhiteRook = false
	cursorIsWhiteQueen = false
	cursorIsBlackPawn = false
	cursorIsBlackKnight = false
	cursorIsBlackBishop = false
	cursorIsBlackRook = false
	cursorIsBlackQueen = false
	cursorIsWhiteQueen = true
	Input.set_custom_mouse_cursor(whiteQueenCursor, 0, Vector2(50,50))
