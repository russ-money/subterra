//CONJURE CHAINS--------------------------------

/obj/effect/proc_holder/spell/arcane/chain
	name = "Conjure Chains"
	desc = ""
	overlay_state = "chain"
	sound = 'sound/foley/dropsound/chain_drop.ogg'
	range = 8
	releasedrain = 50
	chargedrain = 1
	chargetime = 10
	charge_max = 60 SECONDS
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/chain/cast(list/targets, mob/living/user)
	. = ..()
	if(iscarbon(targets[1]))
		var/mob/living/carbon/C = targets[1]
		if(!C.lying)
			to_chat(user, span_warning("[C] needs to be lying down."))
			return FALSE
		if(user.aimheight > 4)
			if(!C.handcuffed)
				if(C.get_num_arms(FALSE) || C.get_arm_ignore())
					var/obj/item/cuffs = new /obj/item/rope/chain
					cuffs.forceMove(C)
					C.handcuffed = cuffs
					C.update_handcuffed()
					C.visible_message(span_warning("[user] conjured magic shackles in [C]'s hands."), \
										span_danger("[user] ties me up with magic shackles."))
					SSblackbox.record_feedback("tally", "handcuffs", 1, type)
					log_combat(user, C, "handcuffed")
					return TRUE
				else
					to_chat(user, span_warning("[C] has no arms to tie up."))
			else
				to_chat(user, span_warning("[C] is already tied."))
		if(user.aimheight <= 4)
			if(!C.legcuffed)
				if(C.get_num_legs(TRUE) == 2)
//					if(do_mob(user, C, 60) && (C.get_num_legs(FALSE) < 2))
					var/obj/item/cuffs = new /obj/item/rope/chain
					cuffs.forceMove(C)
					C.legcuffed = cuffs
					C.update_inv_legcuffed()
					C.visible_message(span_warning("[user] conjured magic shackles in [C]'s legs."), \
										span_danger("[user] ties my legs with magic shackles."))
					SSblackbox.record_feedback("tally", "legcuffs", 1, type)
					log_combat(user, C, "legcuffed", TRUE)
					return TRUE
				else
					to_chat(user, span_warning("[C] is missing two or one legs."))
			else
				to_chat(user, span_warning("[C] is already tied."))
	return FALSE
