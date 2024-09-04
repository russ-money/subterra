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
	smoke_spread = 1	//Just Smoke
	smoke_amt = 2

/obj/effect/proc_holder/spell/arcane/smokescreen/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		return TRUE
	else if(isopenturf(targets[1]))
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
	smoke_spread = 2  //Now it makes the target cough and drop items in hand
	smoke_amt = 1

/obj/effect/proc_holder/spell/arcane/densesmoke/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		return TRUE
	else if(isopenturf(targets[1]))
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
	smoke_spread = 3  //Now this will make the target to fall asleep
	smoke_amt = 2

/obj/effect/proc_holder/spell/arcane/sleepgas/cast(list/targets,mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		return TRUE
	else if(isopenturf(targets[1]))
		return TRUE
	return FALSE