// INVISIBILITY--------------

/obj/effect/proc_holder/spell/arcane/invisibility
	name = "Invisibility"
	desc = ""
	overlay_state = "invisibility"
	releasedrain = 50
	chargedrain = 0
	chargetime = 0
	charge_max = 30 SECONDS
	range = 3
	movement_interrupt = FALSE
	sound = 'sound/misc/area.ogg' //This sound doesnt play for some reason. Fix me.
	antimagic_allowed = TRUE
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/invisibility/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(span_warning("[target] starts to fade into thin air!"), span_notice("You start to become invisible!"))
		animate(target, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
		target.mob_timers[MT_INVISIBILITY] = world.time + 15 SECONDS
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 15 SECONDS)
		addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[target] fades back into view."), span_notice("You become visible again.")), 15 SECONDS)
	return FALSE