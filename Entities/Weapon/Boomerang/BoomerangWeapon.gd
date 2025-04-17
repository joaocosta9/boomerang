# BoomerangWeapon.gd
class_name BoomerangWeapon
extends Weapon

var boomerang_scene = preload("res://Entities/Weapon/Boomerang/boomerang.tscn")
var active_boomerang = null

func attack():
	if active_boomerang != null:
		return
		
	character.sprite_2d.animation = "boomerang_throw"
		
	var boomerang = boomerang_scene.instantiate()
	
	character.get_parent().add_child(boomerang)
	var spawn_point = character.get_node("WeaponSpawnMarker")
	
	print(spawn_point.global_position)	
	boomerang.global_position = spawn_point.global_position

	
	var script = boomerang.get_script()
	if script:
		boomerang.set("direction", -1 if character.isLeft else 1)
		boomerang.set("weapon", self)
	else:
		print("ERROR: Boomerang has no script attached!")
	
	active_boomerang = boomerang

func boomerang_returned():
	active_boomerang = null
