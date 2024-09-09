//DECAY BOLT---------------

/obj/effect/proc_holder/spell/arcane/projectile/decaybolt
	name = "Decay Bolt"
	desc = ""
	overlay_state = "decay"
	range = 8
	projectile_type = /obj/projectile/magic/decaybolt
	sound = 'sound/misc/portal_enter.ogg'
	releasedrain = 30
	chargedrain = 1
	chargetime = 10
	charge_max = 10 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 3
	learnable = TRUE

/obj/projectile/magic/decaybolt
	name = "sickness"
	icon_state = "xray"
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	range = 15

/obj/projectile/magic/decaybolt/on_hit(target,mob/user = usr)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(iscarbon(target))
			var/mob/living/carbon/L = target
			L.add_nausea(15)
			L.adjustToxLoss(5, 0)
