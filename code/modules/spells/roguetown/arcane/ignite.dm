//IGNITE------------------

/obj/effect/proc_holder/spell/arcane/ignite
	name = "Ignite"
	desc = ""
	overlay_state = "flame"
	sound = 'sound/items/firelight.ogg'
	range = 4
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	charge_max = 10 SECONDS

/obj/effect/proc_holder/spell/arcane/ignite/cast(list/targets, mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/L = targets[1]
		user.visible_message("<font color='yellow'>[user] points at [L]!</font>")
		if(L.anti_magic_check(TRUE, TRUE))
			return FALSE
		L.adjust_fire_stacks(5)
		L.IgniteMob()
		addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, ExtinguishMob)), 5 SECONDS)
		return TRUE

	// Spell interaction with ignitable objects (burn wooden things, light torches up)
	else if(isobj(targets[1]))
		var/obj/O = targets[1]
		if(O.fire_act())
			user.visible_message("<font color='yellow'>[user] points at [O], igniting it in flames!</font>")
			return TRUE
		else
			to_chat(user, span_warning("You point at [O], but it fails to catch fire."))
			return FALSE
	return FALSE