//SWAP PLACES-----------------

/obj/effect/proc_holder/spell/arcane/swap
	name = "Location Swap"
	desc = ""
	overlay_state = "swap"
	sound = 'sound/magic/magic_nulled.ogg'
	range = 8
	releasedrain = 50
	chargedrain = 1
	chargetime = 15
	charge_max = 30 SECONDS
	charging_slowdown = 3
	learnable = TRUE
	var/include_space = FALSE //whether it includes space tiles in possible teleport locations
	var/include_dense = FALSE //whether it includes dense tiles in possible teleport locations

/obj/effect/temp_visual/swap
	icon_state = "anom"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER

/obj/effect/proc_holder/spell/arcane/swap/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		new /obj/effect/temp_visual/swap(get_turf(user))
		new /obj/effect/temp_visual/swap(get_turf(target))
		var/atom/targl = get_turf(target)
		if(do_teleport(target, user, forceMove = TRUE, channel = TELEPORT_CHANNEL_MAGIC))
			do_teleport(user, targl, forceMove = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		if(ismob(target))
			var/mob/M = target
			to_chat(M, span_warning("You find myself somewhere else..."))
	return TRUE
