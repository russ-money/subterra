//This is basically a pseudo spell/Invoked clone
//Might as well do this if we end having both arcane and divine versions some spells
//That will also help organizing future lists and shit (specially if we are adding spell books later)

/obj/effect/proc_holder/spell/arcane
	name = "arcane spell"
	range = -1
	selection_type = "range"
	no_early_release = TRUE
	charge_max = 30
	charge_type = "recharge"
	invocation_type = "shout"
	var/active_sound
	clothes_req = FALSE
	warnie = "spellwarning"
	no_early_release = TRUE
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charging_slowdown = 1
	var/learnable = FALSE //If the spell can be learnable by spellbooks, FALSE by default to avoid dumb issues. put TRUE individually on those that can be learnt via craftable spellbooks.

/obj/effect/proc_holder/spell/arcane/Click()
	var/mob/living/user = usr
	if(!istype(user))
		return
	if(!can_cast(user))
		start_recharge()
		deactivate(user)
		return
	if(active)
		deactivate(user)
	else
		if(active_sound)
			user.playsound_local(user,active_sound,100,vary = FALSE)
		active = TRUE
		add_ranged_ability(user, null, TRUE)
		on_activation(user)
	update_icon()
	start_recharge()

/obj/effect/proc_holder/spell/arcane/deactivate(mob/living/user)
	..()
	active = FALSE
	remove_ranged_ability(null)
	on_deactivation(user)

/obj/effect/proc_holder/spell/arcane/proc/on_activation(mob/user)
	return

/obj/effect/proc_holder/spell/arcane/proc/on_deactivation(mob/user)
	return

/obj/effect/proc_holder/spell/arcane/InterceptClickOn(mob/living/caller, params, atom/target)
	. = ..()
	if(.)
		return FALSE
	if(!can_cast(caller) || !cast_check(FALSE, ranged_ability_user))
		return FALSE
	if(perform(list(target), TRUE, user = ranged_ability_user))
		caller.mind.adjust_experience(associated_skill, (caller.STAINT*0.3))//Arcane Skill exp gain - Delete/Edit if on your leisure
		return TRUE

/obj/effect/proc_holder/spell/arcane/projectile
	var/projectile_type = /obj/projectile/magic/teleport
	var/list/projectile_var_overrides = list()
	var/projectile_amount = 1	//Projectiles per cast.
	var/current_amount = 0	//How many projectiles left.
	var/projectiles_per_fire = 1		//Projectiles per fire. Probably not a good thing to use unless you override ready_projectile().

/obj/effect/proc_holder/spell/arcane/projectile/proc/ready_projectile(obj/projectile/P, atom/target, mob/user, iteration)
	return

/obj/effect/proc_holder/spell/arcane/projectile/cast(list/targets, mob/living/user)
	. = ..()
	var/target = targets[1]
	var/turf/T = user.loc
	var/turf/U = get_step(user, user.dir) // Get the tile infront of the move, based on their direction
	if(!isturf(U) || !isturf(T))
		return FALSE
	fire_projectile(user, target)
	user.newtonian_move(get_dir(U, T))
	update_icon()
	start_recharge()
	return TRUE

/obj/effect/proc_holder/spell/arcane/projectile/proc/fire_projectile(mob/living/user, atom/target)
	current_amount--
	for(var/i in 1 to projectiles_per_fire)
		var/obj/projectile/P = new projectile_type(user.loc)
		if(istype(P, /obj/projectile/magic/bloodsteal))
			var/obj/projectile/magic/bloodsteal/B = P
			B.sender = user
		P.firer = user
		P.preparePixelProjectile(target, user)
		for(var/V in projectile_var_overrides)
			if(P.vars[V])
				P.vv_edit_var(V, projectile_var_overrides[V])
		ready_projectile(P, target, user, i)
		P.fire()
	return TRUE

/obj/effect/proc_holder/spell/arcane/targeted //can mean aoe for mobs (limited/unlimited number) or one target mob
	var/max_targets = 1 //leave 0 for unlimited targets in range, 1 for one selectable target in range, more for limited number of casts (can all target one guy, depends on target_ignore_prev) in range
	var/target_ignore_prev = 1 //only important if max_targets > 1, affects if the spell can be cast multiple times at one person from one cast
	var/include_user = 0 //if it includes usr in the target list
	var/random_target = 0 // chooses random viable target instead of asking the caster
	var/random_target_priority = TARGET_CLOSEST // if random_target is enabled how it will pick the target


/obj/effect/proc_holder/spell/arcane/aoe_turf //affects all turfs in view or range (depends)
	var/inner_radius = -1 //for all your ring spell needs

/obj/effect/proc_holder/spell/arcane/targeted/choose_targets(mob/user = usr)
	var/list/targets = list()

	switch(max_targets)
		if(0) //unlimited
			for(var/mob/living/target in view_or_range(range, user, selection_type))
				if(!can_target(target))
					continue
				targets += target
		if(1) //single target can be picked
			if(range < 0)
				targets += user
			else
				var/possible_targets = list()

				for(var/mob/living/M in view_or_range(range, user, selection_type))
					if(!include_user && user == M)
						continue
					if(!can_target(M))
						continue
					possible_targets += M

				//targets += input("Choose the target for the spell.", "Targeting") as mob in possible_targets
				//Adds a safety check post-input to make sure those targets are actually in range.
				var/mob/M
				if(!random_target)
					M = input("Choose the target for the spell.", "Targeting") as null|mob in sortNames(possible_targets)
				else
					switch(random_target_priority)
						if(TARGET_RANDOM)
							M = pick(possible_targets)
						if(TARGET_CLOSEST)
							for(var/mob/living/L in possible_targets)
								if(M)
									if(get_dist(user,L) < get_dist(user,M))
										if(los_check(user,L))
											M = L
								else
									if(los_check(user,L))
										M = L
				if(M in view_or_range(range, user, selection_type))
					targets += M

		else
			var/list/possible_targets = list()
			for(var/mob/living/target in view_or_range(range, user, selection_type))
				if(!can_target(target))
					continue
				possible_targets += target
			for(var/i=1,i<=max_targets,i++)
				if(!possible_targets.len)
					break
				if(target_ignore_prev)
					var/target = pick(possible_targets)
					possible_targets -= target
					targets += target
				else
					targets += pick(possible_targets)

	if(!include_user && (user in targets))
		targets -= user

	if(!targets.len && !cast_without_targets) //doesn't waste the spell
		revert_cast(user)
		return

	perform(targets,user=user)

/obj/effect/proc_holder/spell/arcane/aoe_turf/choose_targets(mob/user = usr)
	var/list/targets = list()

	for(var/turf/target in view_or_range(range,user,selection_type))
		if(!can_target(target))
			continue
		if(!(target in view_or_range(inner_radius,user,selection_type)))
			targets += target

	if(!targets.len) //doesn't waste the spell
		revert_cast()
		return

	perform(targets,user=user)
