//ARCANE LIGHT------------------------------

/obj/effect/proc_holder/spell/arcane/light
	name = "Arcane Light"
	desc = ""
	overlay_state = "light"
	sound = 'sound/magic/magic_nulled.ogg'
	range = 8
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 40 SECONDS
	charging_slowdown = 1
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/light/cast(list/targets, mob/living/carbon/user = usr)
	var/light_power = clamp(4 + (user.mind.get_skill_level(/datum/skill/magic/arcane) - 3), 4, 7) // every step above journeyman should get us 1 more tile of brightness
	var/mob/living/carbon/human/H = user
	var/light_color = "#[H.voice_color]"//"#3FBAFD"
	user.mob_light(_range = light_power, _power = 3, _color = light_color, _duration = 30 SECONDS)
	user.visible_message(span_notice("[user] conjures light from the palm of [user.p_their()] hand"), span_notice("I conjure light from the palm of my hand..."))
	return TRUE