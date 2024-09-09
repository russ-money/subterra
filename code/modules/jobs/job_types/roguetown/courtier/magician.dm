/datum/job/roguetown/magician
	title = "Court Magician"
	flag = WIZARD
	department_flag = COURTIERS
	selection_color = JCOLOR_COURTIER
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Aasimar",
	)
	display_order = JDO_MAGICIAN
	tutorial = "Your creed is one dedicated to the conquering of the arcane arts and the constant thrill of knowledge. \
		You owe your life to the Lord, for it was his coin that allowed you to continue your studies in these dark times. \
		In return, you have proven time and time again as justicar and trusted advisor to their reign."
	outfit = /datum/outfit/job/roguetown/magician
	whitelist_req = TRUE
	give_bank_account = 47
	min_pq = 2
	max_pq = null

/datum/outfit/job/roguetown/magician
	allowed_patrons = list(/datum/patron/divine/noc)

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/talkstone
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/keyring/mage
	id = /obj/item/clothing/ring/gold
	r_hand = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/slimepotion/lovepotion,/obj/item/reagent_containers/glass/bottle/rogue/poison,/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	ADD_TRAIT(H, TRAIT_SEEPRICES, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, pick(6,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 4)
		if(H.age == AGE_OLD)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			if(ishumannorthern(H))
				belt = /obj/item/storage/belt/rogue/leather/plaquegold
				cloak = null
				head = /obj/item/clothing/head/roguetown/wizhat
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard
				H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()

		var/list/possible_spells = list(
			"/obj/effect/proc_holder/spell/arcane/telepathy",
			"/obj/effect/proc_holder/spell/arcane/ignite",
			"/obj/effect/proc_holder/spell/arcane/blink",
			"/obj/effect/proc_holder/spell/arcane/swap",
			"/obj/effect/proc_holder/spell/arcane/smokescreen",
			"/obj/effect/proc_holder/spell/arcane/projectile/lightningbolt",
			"/obj/effect/proc_holder/spell/arcane/blindness",
			"/obj/effect/proc_holder/spell/arcane/invisibility",
			"/obj/effect/proc_holder/spell/arcane/projectile/fetch",
			"/obj/effect/proc_holder/spell/arcane/mist",
			"/obj/effect/proc_holder/spell/arcane/web"
		)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/arcane/projectile/fireball/greater)
		for(var/i=3,i>0,i--)
			var/random_item = pick(possible_spells)
			var typepath = text2path(random_item)
			H.mind.AddSpell(new typepath)
			possible_spells.Remove(random_item)
		possible_spells = null
