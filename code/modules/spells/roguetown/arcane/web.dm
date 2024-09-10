//SPIDER WEB

/obj/effect/proc_holder/spell/arcane/web
	name = "Conjure Web"
	desc = ""
	overlay_state = "web"
	range = 8
	sound = 'sound/magic/webspin.ogg'
	releasedrain = 30
	chargedrain = 1
	chargetime = 10
	charge_max = 60 SECONDS
	learnable = TRUE

/obj/effect/proc_holder/spell/arcane/web/cast(list/targets,mob/user = usr)
	. = ..()
/*	if(isliving(targets[1]) | isopenturf(targets[1]))
		var/atom/location = get_turf(targets[1])
		if(location in oview(range,user))
			new /obj/structure/spider/stickyweb(location)
		return TRUE
	return FALSE*/
	if(isliving(targets[1]) | isopenturf(targets[1]))
		var/atom/location = get_turf(targets[1])
		new /obj/structure/spider/stickyweb(location)
		for(var/atom/T in oview(1,location))
			if(T.x == location.x | T.y == location.y)//make it a cross instead of a damn square
				if(prob(50))
					new /obj/structure/spider/stickyweb(T)
		return TRUE
	return FALSE