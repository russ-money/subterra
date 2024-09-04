//LIGHTNING---------------

/obj/effect/proc_holder/spell/arcane/projectile/lightningbolt
	name = "Bolt of Lightning"
	desc = ""
	overlay_state = "lightning"
	sound = 'sound/magic/lightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/lightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 10 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 3
	learnable = TRUE

/obj/projectile/magic/lightning
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	light_color = LIGHT_COLOR_WHITE
	damage = 15
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#ffffff"
	light_range = 7

/obj/projectile/magic/lightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
//			for(var/obj/item/I in L.get_equipped_items())	//Maybe add 5 damage for each metal gear in the target?
//				if(I.smeltresult == /obj/item/ingot/iron)	//More damage if the target is on water tuff too?
//					damage += 5    							//(dont know it that code work tho)
			L.electrocute_act(1, src)
	qdel(src)