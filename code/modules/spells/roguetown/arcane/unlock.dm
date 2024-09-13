//UNLOCK----------------------

/obj/effect/proc_holder/spell/arcane/unlock
	name = "Unlock"
	desc = ""
	overlay_state = "lock"
	range = 8
	releasedrain = 60
	chargedrain = 0
	chargetime = 5 SECONDS
	charge_max = 20 SECONDS
	charging_slowdown = 2
	movement_interrupt = TRUE
	learnable = FALSE

/obj/effect/proc_holder/spell/arcane/unlock/cast(list/targets, mob/user = usr)
	var/atom/location = get_turf(targets[1])
	var/prob2open = 0
	var/diceroll = 0
	for(var/obj/structure/mineral_door/door in location)
		if (door in range(1, user))
			diceroll = rand(0,100)
			prob2open = 20 + (user.mind.get_skill_level(/datum/skill/magic/arcane) * 5)
			if (diceroll <= prob2open)
				playsound(get_turf(user), 'sound/misc/chestclose.ogg', 100, TRUE, -1)
				INVOKE_ASYNC(src, PROC_REF(open_door), door)
			else
				to_chat(user, "<span class='warning'>You fail to cast the spell...</span>")
			return TRUE
		to_chat(user, "<span class='warning'>You need to get closer...</span>")
	for(var/obj/structure/closet/C in location)
		if (C in range(1, user))
			diceroll = rand(0,100)
			prob2open = 20 + (user.mind.get_skill_level(/datum/skill/magic/arcane) * 5)
			if (diceroll <= prob2open)
				playsound(get_turf(user), 'sound/misc/chestopen.ogg', 100, TRUE, -1)
				INVOKE_ASYNC(src, PROC_REF(open_closet), C)
			else
				to_chat(user, "<span class='warning'>You fail to cast the spell...</span>")
			return TRUE
		to_chat(user, "<span class='warning'>You need to get closer...</span>")
	to_chat(user, "<span class='warning'>There is nothing the spell can unlock here.</span>")
	return FALSE

/obj/effect/proc_holder/spell/arcane/unlock/proc/open_door(obj/structure/mineral_door/door, mob/user = usr)
	if(door.door_opened || door.isSwitchingStates || !door.locked)
		to_chat(user, "<span class='warning'>It is already open.</span>")
		return
	if(!door.keylock)
		to_chat(user, "<span class='warning'>There's no lock on this.</span>")
		return
	if(door.lockbroken)
		to_chat(user, "<span class='warning'>The lock is broken.</span>")
		return
	to_chat(user, "<span class='warning'>You unlock the door.</span>")
	door.locked = FALSE
	return

/obj/effect/proc_holder/spell/arcane/unlock/proc/open_closet(obj/structure/closet/C, mob/user = usr)
	if(!C.locked)
		to_chat(user, "<span class='warning'>It is already open.</span>")
		return
	to_chat(user, "<span class='warning'>You unlock the closet.</span>")
	C.locked = FALSE
	return
