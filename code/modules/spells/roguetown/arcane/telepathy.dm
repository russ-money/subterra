//TELEPATHY---------------------------

/obj/effect/proc_holder/spell/arcane/telepathy
	name = "Telepathy"
	desc = ""
	range = 15
	overlay_state = "psy"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 20
	chargedrain = 0
	chargetime = 0
	charge_max = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/telepathy/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		var/input = stripped_input(user, "What message are you sending?", null, "")
		if(!input)
			return FALSE
		to_chat(user, span_warning("I transmit to [target]: " + "[input]"))
		to_chat(target, span_warning("You hear a voice in your head saying: ") + span_boldwarning("[input]"))
		return TRUE