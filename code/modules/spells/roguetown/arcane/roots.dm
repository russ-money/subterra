//ENSNARING ROOTS------------------

/obj/effect/proc_holder/spell/arcane/ensnare
	name = "Ensnaring Roots"
	desc = ""
	overlay_state = "root"
	range = 6
	releasedrain = 40
	chargedrain = 1
	chargetime = 20
	charge_max = 30 SECONDS
	charging_slowdown = 3
	learnable = FALSE
	var/area_of_effect = 1
	var/duration = 4 SECONDS

/obj/effect/proc_holder/spell/arcane/ensnare/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])

	for(var/turf/affected_turf in view(area_of_effect, T))
		if(affected_turf.density)
			continue
		new /obj/effect/temp_visual/ensnare(affected_turf)

	addtimer(CALLBACK(src, PROC_REF(apply_slowdown), T, area_of_effect, duration, user), 0.5 SECONDS)
	playsound(T,'sound/magic/webspin.ogg', 50, TRUE)
	return TRUE

/obj/effect/proc_holder/spell/arcane/ensnare/proc/apply_slowdown(turf/T, area_of_effect, duration)
	for(var/mob/living/simple_animal/hostile/animal in range(area_of_effect, T))
//		animal.Paralyze(duration, updating = TRUE, ignore_canstun = TRUE)	//i think animal movement is coded weird, i cant seem to stun them
		animal.Immobilize(duration)
		animal.visible_message("<span class='warning'>[animal] is held by conjured roots!</span>")
	for(var/mob/living/L in range(area_of_effect, T))
		if(L.anti_magic_check())
			visible_message(span_warning("The roots can't seem to latch onto [L] "))  //antimagic needs some testing
			playsound(get_turf(L), 'sound/magic/magic_nulled.ogg', 100)
			return
		L.Immobilize(duration)
		L.visible_message("<span class='warning'>[L] is held by conjured roots!</span>")
		new /obj/effect/temp_visual/ensnare/long(get_turf(L))

/obj/effect/temp_visual/ensnare
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = "thornbush"
	duration = 1 SECONDS

/obj/effect/temp_visual/ensnare/long
	duration = 5 SECONDS
