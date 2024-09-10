//SMOKESCREEN-----------------

/obj/effect/proc_holder/spell/arcane/smokescreen
	name = "Smokescreen"
	desc = ""
	overlay_state = "smoke"
	sound = 'sound/items/firesnuff.ogg'
	range = 8
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	charge_max = 10 SECONDS
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/smokescreen/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]) | isopenturf(targets[1]))
		var/atom/location = get_turf(targets[1])
		for(var/atom/T in oview(1,location))
			if(T.x == location.x | T.y == location.y)//make it a cross instead of a damn square
				var/datum/effect_system/smoke_spread/smoke = new
				smoke.set_up(1, T)
				smoke.start()
		return TRUE
	return FALSE

//DENSE SMOKE-------------------

/obj/effect/proc_holder/spell/arcane/densesmoke
	name = "Dense Smoke"
	desc = ""
	overlay_state = "smoke"
	sound = 'sound/items/firesnuff.ogg'
	range = 8
	releasedrain = 40
	chargedrain = 1
	chargetime = 10
	charge_max = 15 SECONDS
	learnable = FALSE

/obj/effect/proc_holder/spell/arcane/densesmoke/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]) | isopenturf(targets[1]))
		var/atom/location = get_turf(targets[1])
		if(location in oview(range,user))
			var/datum/effect_system/smoke_spread/bad/smoke  = new
			smoke.set_up(1, location)
			smoke.start()
			return TRUE
	return FALSE

//SLEEPING GAS-------------------

/obj/effect/proc_holder/spell/arcane/sleepgas
	name = "Sleeping Gas"
	desc = ""
	overlay_state = "smoke"
	sound = 'sound/items/firesnuff.ogg'
	range = 8
	releasedrain = 60
	chargedrain = 1
	chargetime = 30
	charge_max = 30 SECONDS
	learnable = FALSE

/obj/effect/proc_holder/spell/arcane/sleepgas/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]) | isopenturf(targets[1]))
		var/atom/location = get_turf(targets[1])
		if(location in oview(range,user))
			var/datum/effect_system/smoke_spread/sleeping/smoke  = new
			smoke.set_up(1, location)
			smoke.start()
			return TRUE
	return FALSE

//MIST-----------------

/obj/effect/proc_holder/spell/arcane/mist
	name = "Conjure Mist"
	desc = ""
	overlay_state = "mist"
	sound = 'sound/items/firesnuff.ogg'
	range = 8
	releasedrain = 50
	chargedrain = 1
	chargetime = 30
	charge_max = 60 SECONDS
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/mist/cast(list/targets,mob/user = usr)
	. = ..()
	var/atom/location = get_turf(user)
	for(var/atom/T in oview(5,location))
		if(!(T in oview(1,location)))
			if(prob(35))
				var/datum/effect_system/smoke_spread/smoke = new
				smoke.set_up(1, T)
				smoke.start()
	return TRUE
