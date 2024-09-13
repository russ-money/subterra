//FIRE WALL-----------------

/obj/effect/proc_holder/spell/arcane/firewall
	name = "Fire Wall"
	desc = ""
	overlay_state = "fwall"
	sound = 'sound/items/firesnuff.ogg'
	range = 8
	releasedrain = 30
	chargedrain = 1
	chargetime = 20
	charge_max = 40 SECONDS
	learnable = FALSE
	charging_slowdown = 2

/obj/effect/proc_holder/spell/arcane/firewall/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]) || isopenturf(targets[1]))
		var/atom/location = get_turf(targets[1])
		explosion(location,0,0,0,0,FALSE,,1,,FALSE,FALSE)
		if(user.dir == SOUTH || user.dir == NORTH)
			explosion(get_step(location, EAST),0,0,0,0,FALSE,,1,,FALSE,FALSE)
			explosion(get_step(location, WEST),0,0,0,0,FALSE,,1,,FALSE,FALSE)
		else
			explosion(get_step(location, NORTH),0,0,0,0,FALSE,,1,,FALSE,FALSE)
			explosion(get_step(location, SOUTH),0,0,0,0,FALSE,,1,,FALSE,FALSE)
		return TRUE
	return FALSE