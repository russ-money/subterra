//Wildlife spawners that periodically spawn huntable mobs
/obj/structure/spawner/wildlife
	name = "old tree"
	desc = "An old, wicked tree that not even elves could love."

	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "t1"

	faction = list("neutral")
	spawn_time = 3000 // 5 minutes per spawn, we don't want to flood the area with mobs
	max_mobs = 3
	max_integrity = -1
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/rogue/saiga)
	spawn_text = "emerges from behind"

	move_resist = INFINITY
	anchored = TRUE
