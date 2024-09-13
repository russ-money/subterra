//FEATHER-------------------------------

/obj/effect/proc_holder/spell/arcane/feather
	name = "Feather Step"
	desc = ""
	overlay_state = "feather"
	sound = 'sound/magic/magic_nulled.ogg'
	range = 8
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 5 SECONDS
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/feather/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return TRUE
		target.apply_status_effect(/datum/status_effect/buff/feather)
		return TRUE
	return FALSE
