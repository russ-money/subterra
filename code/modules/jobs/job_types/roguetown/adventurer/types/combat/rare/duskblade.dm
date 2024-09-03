//duskblade

/datum/advclass/duskblade
	name = "Duskblade"
	tutorial = "The duskblade blurs the line between spellcaster and warrior,\
	marrying the power of magic with hand-to-hand combat prowess. A student of ancient elven spellcasting techniques,\
	the duskblade combines arcane spellcasting with the combat skills of a fighter."
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar",
		"Half Orc"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/dblade
	pickprob = 11
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_DODGEEXPERT)
	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/dblade/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, rand(1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, rand(1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, pick(1,2,3), TRUE)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 1)
	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	if(prob(70))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	else if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	else
		armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	if(prob(25))
		mask = /obj/item/clothing/mask/rogue/facemask
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/wood
	beltl = /obj/item/rogueweapon/huntingknife
	if(prob(50))
		beltr = /obj/item/rogueweapon/sword/iron
	else
		beltr = /obj/item/rogueweapon/sword/sabre
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
	else
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_BLACK
		H.update_body()
		pants = /obj/item/clothing/under/roguetown/tights/black

	var/list/possible_spells = list(
		"/obj/effect/proc_holder/spell/arcane/telepathy",
		"/obj/effect/proc_holder/spell/arcane/ignite",
		"/obj/effect/proc_holder/spell/arcane/blink",
		"/obj/effect/proc_holder/spell/arcane/swap",
		"/obj/effect/proc_holder/spell/arcane/smokescreen",
		"/obj/effect/proc_holder/spell/arcane/blindness",
		"/obj/effect/proc_holder/spell/arcane/invisibility",
		"/obj/effect/proc_holder/spell/arcane/projectile/fetch"
	)
	H.mind.AddSpell(pick(new /obj/effect/proc_holder/spell/arcane/projectile/fireball,new /obj/effect/proc_holder/spell/arcane/projectile/lightningbolt))
	var/random_item = pick(possible_spells)
	var typepath = text2path(random_item)
	H.mind.AddSpell(new typepath)
	possible_spells = null

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
