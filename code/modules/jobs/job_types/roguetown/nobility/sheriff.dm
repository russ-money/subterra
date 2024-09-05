/datum/job/roguetown/sheriff
	title = "Guard Captain"
	flag = SHERIFF
	department_flag = NOBLEMEN
	faction = "Station"
	allowed_patrons = ALL_DIVINE_PATRONS
	total_positions = 1
	spawn_positions = 1

	allowed_races = list("Humen")
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Your lineage is noble, and generations of strong, loyal knights have come before you. You served your time gracefully as a knight of his royal majesty, and now you've grown into a role which many men dream to become. Lead your men to victory and keep them in line and you will see this kingdom prosper under a thousand suns."

	display_order = JDO_SHERIFF
	whitelist_req = FALSE

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard)
	outfit = /datum/outfit/job/roguetown/sheriff

	give_bank_account = 26
	min_pq = 4
	max_pq = null

	cmode_music = 'sound/music/combat_guard2.ogg'

/datum/job/roguetown/sheriff/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/cape/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "captain cape ([index])"
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		H.real_name = "Captain [prev_real_name]"
		H.name = "Captain [prev_name]"

/datum/outfit/job/roguetown/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	armor = /obj/item/clothing/suit/roguetown/armor/plate
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/rogueweapon/mace/steel
	beltl = /obj/item/rogueweapon/sword/sabre
	cloak = /obj/item/clothing/cloak/stabard/guardhood
	backl = /obj/item/rogueweapon/shield/tower
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/keyring/sheriff = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 2)
	if(H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell
