extends Node2D


enum AIGoal {
	Idle,
	Stare,
	Scare,
}
var goal = AIGoal.Idle
var target
var general_direction = 1
var deadzone = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$DetectionArea.connect("body_entered", Callable(self, "make_stare"))
	$DetectionArea.connect("body_exited", Callable(self, "stop_stare"))

func make_stare(object):
	if object.is_in_group("alive"):
		target = object
		goal = AIGoal.Stare
func stop_stare(object):
	if object==target:
		goal = AIGoal.Idle
		target = null

func idle():
	var rand = general_direction*randf()/4
	var leg2_rot = $skeleton/leg2.rotation + rand
	var lerped = lerp($skeleton/leg2.rotation, leg2_rot, 0.01)
	$skeleton/leg2.rotation = lerped
	var leg_rot = $skeleton/leg2.rotation - rand
	lerped = lerp($skeleton/leg2.rotation, leg_rot, 0.01)
	$skeleton/leg2/leg.rotation = lerped
	#print($skeleton/leg2/leg/lowbottom_right.rotation)

	# LEAFS
	var move_obj = func (obj):
		var lbr = obj.rotation + (randf())/4 * general_direction
		lerped = lerp(obj.rotation, lbr, 0.01)
		obj.rotation = lerped

	move_obj.call($skeleton/leg2/leg/lowbottom_right)
	move_obj.call($skeleton/leg2/leg/lowbottom_right/bottom_right)
	move_obj.call($skeleton/leg2/leg/lowtop_right)
	move_obj.call($skeleton/leg2/leg/lowtop_right/top_right)

	move_obj.call($skeleton/leg2/leg/lowbottom_left)
	move_obj.call($skeleton/leg2/leg/lowbottom_left/bottom_left)
	move_obj.call($skeleton/leg2/leg/lowtop_left)
	move_obj.call($skeleton/leg2/leg/lowtop_left/top_left)
	
	var move_nectar = func (obj):
		var lbr = obj.rotation + (randf()-0.5)
		lerped = lerp(obj.rotation, lbr, 0.03)
		obj.rotation = lerped
	
	# NECTAR
	move_nectar.call($skeleton/leg2/leg/lowtop_nectar)
	move_nectar.call($skeleton/leg2/leg/lowdown_nectar)
	move_nectar.call($skeleton/leg2/leg/lowdown2_nectar)
	move_nectar.call($skeleton/leg2/leg/lowtop_nectar/top_nectar)
	move_nectar.call($skeleton/leg2/leg/lowdown_nectar/down_nectar)
	move_nectar.call($skeleton/leg2/leg/lowdown2_nectar/down2_nectar)
	
var offset_constant = .55
func stare(object):
	print(object.position)
	var warp = func (a, offset):
		a.rotation = lerp(a.rotation, atan(  (a.position.x - object.position.x) / -(a.position.y - object.position.y)  ) - ((2.5-offset_constant)*PI/4) - offset, 0.3)
		
		#print(a.rotation, " : ", atan(  (a.position.x - object.position.x) / (a.position.y - object.position.y)  ))
		#a.position = lerp(a.position, object.position, 0.001)
	var offset = 0
	for i in [$skeleton/leg2/leg/lowtop_nectar,$skeleton/leg2/leg/lowdown_nectar, $skeleton/leg2/leg/lowdown2_nectar]:
		warp.call(i, offset)
		offset += offset_constant

func scare():
	pass

var tick = 0
func _process(delta):
	if tick%500==0:
		general_direction*=-1
	if tick%5==0:
		match goal:
			AIGoal.Idle:
				idle()
			AIGoal.Stare:
				stare(target)
			AIGoal.Scare:
				scare()
			_:
				pass
	tick+=1
