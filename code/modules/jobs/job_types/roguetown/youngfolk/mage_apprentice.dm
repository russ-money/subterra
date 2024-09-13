/datum/job/roguetown/wapprentice
	title = "Magician Apprentice"
	flag = MAGEAPPRENTICE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
//I disabled it for consistency but this job looks functional so far, I even gave a weak spell selection to them just in case.

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar"
	)
	allowed_ages = YOUNG_AGES_LIST

	tutorial = "Your master once saw potential in you, something you are uncertain if they still do with your recent studies. The path to using magic is something treacherous and untamed, and you are still decades away from calling yourself even a journeyman in the field. Listen and serve, and someday you will earn your hat."

	outfit = /datum/outfit/job/roguetown/wapprentice
	display_order = JDO_MAGEAPPRENTICE
	give_bank_account = TRUE
	min_pq = -5
	max_pq = null

/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, pick(0,1), TRUE)
		var/list/possible_spells = list(
			"/obj/effect/proc_holder/spell/arcane/telepathy",
			"/obj/effect/proc_holder/spell/arcane/ignite",
			"/obj/effect/proc_holder/spell/arcane/smokescreen",
			"/obj/effect/proc_holder/spell/arcane/blindness",
			"/obj/effect/proc_holder/spell/arcane/invisibility",
			"/obj/effect/proc_holder/spell/arcane/projectile/fetch",
			"/obj/effect/proc_holder/spell/arcane/web",
			"/obj/effect/proc_holder/spell/arcane/chain",
			"/obj/effect/proc_holder/spell/arcane/feather",
			"/obj/effect/proc_holder/spell/arcane/light"
		)
		for(var/i=2,i>0,i--)
			var/random_item = pick(possible_spells)
			var typepath = text2path(random_item)
			H.mind.AddSpell(new typepath)
			possible_spells.Remove(random_item)
		possible_spells = null
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/keyring/mageapprentice
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		backr = /obj/item/storage/backpack/rogue/satchel
	else
		shoes = /obj/item/clothing/shoes/roguetown/sandals
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/keyring/mageapprentice
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		backr = /obj/item/storage/backpack/rogue/satchel
	H.change_stat("intelligence", round(rand(0,5)))
	H.change_stat("speed", -1)
