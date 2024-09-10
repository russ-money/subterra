// BLINDNESS--------------

/obj/effect/proc_holder/spell/arcane/blindness
	name = "Blindness"
	desc = ""
	overlay_state = "blindness"
	releasedrain = 40
	chargedrain = 0
	chargetime = 0
	charge_max = 10 SECONDS
	range = 7
	movement_interrupt = FALSE
	sound = 'sound/magic/churn.ogg'
	antimagic_allowed = TRUE
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/blindness/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(span_warning("[user] points at [target]'s eyes!"),span_warning("My eyes are covered in darkness!"))
		target.blind_eyes(user.mind.get_skill_level(/datum/skill/magic/arcane))
		return TRUE
	return FALSE