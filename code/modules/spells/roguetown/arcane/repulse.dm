//FORCE PUSH-----------------------

/obj/effect/proc_holder/spell/arcane/repulse
	name = "Repulse"
	desc = ""
	overlay_state = "force"
	range = 8
	releasedrain = 50
	chargedrain = 0
	chargetime = 0
	charge_max = 30 SECONDS
	charging_slowdown = 2
	learnable = TRUE
	var/stun_amt = 5
	var/maxthrow = 3
	var/repulse_force = MOVE_FORCE_STRONG
	var/push_range = 1

/obj/effect/proc_holder/spell/arcane/repulse/cast(list/targets, mob/user)
	var/list/thrownatoms = list()
	var/atom/throwtarget
	var/distfromcaster
	playsound(user,'sound/magic/swap.ogg', 75, TRUE)
	user.visible_message("[user] conjures forth a brute force arcane wave, repelling anything in front of them!")
	for(var/turf/T in view(push_range, user))
		new /obj/effect/temp_visual/magicpush(T)
		for(var/atom/movable/AM in T)
			thrownatoms += AM

	for(var/am in thrownatoms)
		var/atom/movable/AM = am
		if(AM == user || AM.anchored)
			continue

		if(ismob(AM))
			var/mob/M = AM
			if(M.anti_magic_check())
				continue

		throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(AM, user)))
		distfromcaster = get_dist(user, AM)
		if(distfromcaster == 0)
			if(isliving(AM))
				var/mob/living/M = AM
				M.Paralyze(10)
				M.adjustBruteLoss(5)
				to_chat(M, "<span class='danger'>You're slammed into the floor by [user]!</span>")
		else
			if(isliving(AM))
				var/mob/living/M = AM
				M.Paralyze(stun_amt)
				to_chat(M, "<span class='danger'>You're thrown back by [user]!</span>")
			AM.safe_throw_at(throwtarget, ((CLAMP((maxthrow - (CLAMP(distfromcaster - 2, 0, distfromcaster))), 3, maxthrow))), 1,user, force = repulse_force)//So stuff gets tossed around at the same time.

/obj/effect/temp_visual/magicpush
	icon_state = "empdisable"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
