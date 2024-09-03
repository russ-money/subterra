//Might as well do this if we end having both arcane and divine versions some spells

/obj/effect/proc_holder/spell/arcane
	name = "invoked spell"
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