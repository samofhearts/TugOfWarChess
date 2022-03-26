extends Node2D


var whiteKingsHealthNumber: int = 100
var blackKingsHealthNumber: int = 100

var whiteMoney: int = 10
var blackMoney: int = 10

var gameSpeed: float = 1
var moneySpeed: float = 3

var whiteGoldSpeedUpgradeCost: int = 10
var whiteKingHealthUpgradeCost: int = 10

var blackGoldSpeedUpgradeCost: int = 10
var blackKingHealthUpgradeCost: int = 10

var whiteKingMoneyPerTimer: int = 1
var blackKingMoneyPerTimer: int = 2

var whiteGameSpeedUpgradeCost: int = 10

var whiteQueenRangeUpgradeCost: int = 20
var blackQueenRangeUpgradeCost: int = 20

var whiteQueenRange: int = 2
var blackQueenRange: int = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
