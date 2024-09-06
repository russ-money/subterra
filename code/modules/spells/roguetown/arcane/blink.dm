//BLINK-----------------

/obj/effect/proc_holder/spell/arcane/blink
	name = "Blink"
	desc = ""
	overlay_state = "blink"
	sound = 'sound/magic/magic_nulled.ogg'
	range = 8
	releasedrain = 50
	chargedrain = 0
	chargetime = 0
	charge_max = 15 SECONDS
	var/include_space = FALSE //whether it includes space tiles in possible teleport locations
	var/include_dense = FALSE //whether it includes dense tiles in possible teleport locations
	learnable = TRUE

/obj/effect/temp_visual/blink
	icon_state = "anom"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER

/obj/effect/proc_holder/spell/arcane/blink/cast(list/targets,mob/user = usr)
	. = ..()
	if(isopenturf(targets[1]))
		var/atom/location = get_turf(targets[1])
		if(location in oview(range,user))
			new /obj/effect/temp_visual/swap(get_turf(user))
			new /obj/effect/temp_visual/swap(get_turf(location))
			do_teleport(user, location, forceMove = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
			return TRUE
	return FALSE
