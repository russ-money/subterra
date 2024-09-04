//FETCH-------------------------

/obj/effect/proc_holder/spell/arcane/projectile/fetch
	name = "Fetch"
	desc = ""
	range = 15
	projectile_type = /obj/projectile/magic/fetch
	overlay_state = "fetch"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 5
	chargedrain = 0
	chargetime = 0
	charge_max = 5 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1

/obj/projectile/magic/fetch/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[target] repells the fetch!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK