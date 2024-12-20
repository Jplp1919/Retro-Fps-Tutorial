extends Node3D

@onready var weapons = $Weapons.get_children()
var weapons_unlocked = []
var cur_slot = 0
var cur_weapon = null

func _ready():
	disable_all_weapons()
	for _i in range(weapons.size()):
		weapons_unlocked.append(true)

func disable_all_weapons():
	for weapon in weapons:
		if has_method("set_active"): #implement set active
			weapon.set_active(false)
		else:
			weapon.hide()

func switch_to_previous_weapon():
	for i in range(weapons.size()):
		var wrapped_ind = wrapi(cur_slot -1 -i, 0, weapons.size())
		if switch_to_weapon_slot(wrapped_ind):
			break

func switch_to_next_weapon():
	for i in range(weapons.size()):
		var wrapped_ind = wrapi(cur_slot +1 +i, 0, weapons.size())
		if switch_to_weapon_slot(wrapped_ind):
			break

func switch_to_weapon_slot(slot_ind: int)->bool:
	if slot_ind >= weapons.size() or slot_ind < 0:
		return false
	if weapons_unlocked.size() == 0 or !weapons_unlocked[slot_ind]:
		return false
	disable_all_weapons()
	cur_slot = slot_ind
	cur_weapon = weapons[cur_slot]
	if has_method("set_active"): #implement set active
		cur_weapon.set_active(true)
	else:
		cur_weapon.show()
	
	return true

func test_attack_animation():
	for weapon in weapons:
		weapon.get_node("Graphics/AnimationPlayer").play("attack")
