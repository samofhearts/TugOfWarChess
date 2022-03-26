extends AnimatedSprite

## Timers
var animTimer = Timer.new()

## RANDOM
var rng = RandomNumberGenerator.new()

## Anim Speed
var animSpeed : float = 12


## Game Timer Function
func _animTimerHit():
	self.play()
	yield(self,"animation_finished")
	self.play()
	yield(self,"animation_finished")
	self.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	animTimer.set_wait_time(animSpeed)
	animTimer.set_one_shot(false)
	animTimer.set_paused(false)
	animTimer.connect("timeout", self, "_animTimerHit")
	animTimer.set_autostart(true)
	add_child(animTimer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
