extends Area2D

## Main Script
onready var main = get_node("/root/Main")

## Timers
var moveTimer = Timer.new()
var upgradeTimer = Timer.new()

## RANDOM
var rng = RandomNumberGenerator.new()

## Game Speed
var moveSpeed : float = 4.5
var upgradeSpeed : float = 180

## Game Timer Function
func _moveTimerHit():
	rng.randomize()
	var ranLoc = rng.randi_range(0,7)
	var ranPiece = rng.randi_range(0,4)
	main.ai_spawn_piece(ranPiece,ranLoc)
	
## Game Timer Function
func _upgradeTimerHit():
	GlobalVariables.blackMoney -= GlobalVariables.blackGoldSpeedUpgradeCost
	GlobalVariables.blackKingMoneyPerTurn += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	moveTimer.set_wait_time(moveSpeed)
	moveTimer.set_one_shot(false)
	moveTimer.set_paused(false)
	moveTimer.connect("timeout", self, "_moveTimerHit")
	moveTimer.set_autostart(true)
	add_child(moveTimer)
	
	upgradeTimer.set_wait_time(upgradeSpeed)
	upgradeTimer.set_one_shot(false)
	upgradeTimer.set_paused(false)
	upgradeTimer.connect("timeout", self, "_upgradeTimerHit")
	upgradeTimer.set_autostart(true)
	add_child(upgradeTimer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
