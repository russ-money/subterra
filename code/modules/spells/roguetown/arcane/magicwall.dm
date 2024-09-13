//MAGIC WALL----------------------

/obj/effect/proc_holder/spell/arcane/magicwall
	name = "Magic Wall"
	desc = ""
	overlay_state = "wall"
	range = 8
	releasedrain = 50
	chargedrain = 1
	chargetime = 15
	charge_max = 60 SECONDS
	charging_slowdown = 3
	sound = 'sound/magic/magic_nulled.ogg'
	learnable = FALSE
	var/wall_type = /obj/structure/magicwall/caster

/obj/structure/magicwall
	desc = "A wall of pure arcyne force."
	name = "Arcyne Wall"
	icon = 'icons/effects/effects.dmi'
	icon_state = "m_shield"
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	opacity = 0
	density = TRUE
	max_integrity = 80
	var/timeleft = 20 SECONDS

/obj/structure/magicwall/Initialize()
	. = ..()
	if(timeleft)
		QDEL_IN(src, timeleft) //delete after it runs out

/obj/effect/proc_holder/spell/arcane/magicwall/cast(list/targets,mob/user = usr)
	new wall_type(get_turf(user),user)
	if(user.dir == SOUTH || user.dir == NORTH)
		new wall_type(get_step(user, EAST),user)
		new wall_type(get_step(user, WEST),user)
	else
		new wall_type(get_step(user, NORTH),user)
		new wall_type(get_step(user, SOUTH),user)
	return TRUE

/obj/structure/magicwall
	var/mob/caster

/obj/structure/magicwall/caster/Initialize(mapload, mob/summoner)
	. = ..()
	caster = summoner

/obj/structure/magicwall/caster/CanPass(atom/movable/mover, turf/target)//only the caster can move through this freely
	if(mover == caster)
		return TRUE
	if(ismob(mover))
		var/mob/M = mover
		if(M.anti_magic_check(chargecost = 0))
			return TRUE
	return FALSE
