/*
Directory:
    code/modules/reagents/chemistry/readme.md for general info
    code/modules/reagents/chemistry/reagents.dm for vars
    code/modules/reagents/chemistry/recipes.dm for recipe info
*/

/datum/reagent/warmongers
    // Basic shit -- what it is, what it does, what it looks like
    name = ""
    description = ""
    taste_description = "" // ... you taste _____
    color = "#FFFFFF" // heh

    // Actual functionality
    reagent_state = LIQUID
    taste_mult = 1 // How this taste compares to others, higher values means it is more noticable
    metabolization_rate = REAGENTS_METABOLISM // "How many units of reagent are consumed per tick, by default"
    overdose_threshold = 0 // If above this number, starts the overdose_process effects listed for that reagent

/*
######### MEDICINES
*/

/datum/reagent/warmongers/medicine
    name = "Medicine"
    description = "It heals you, probably."
    taste_description = "bitterness"
    color = "#FFFFFF"

/datum/reagent/warmongers/medicine/on_mob_life(mob/living/carbon/M)
	current_cycle++
	. = ..()

/datum/reagent/warmongers/medicine/rootjuice
    name = "Root Juice"
    description = "The power of the roots will heal you."
    taste_description = "rootiness"
    color = "#C6C28D"

/datum/reagent/warmongers/medicine/rootjuice/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-0.5*REM, 0)
	M.adjustOxyLoss(-0.5*REM, 0)
	M.adjustBruteLoss(-0.5*REM, 0)
	M.adjustFireLoss(-0.5*REM, 0)
	..()
	. = 1

/datum/reagent/warmongers/medicine/slurry
	name = "Slurry"
	description = "Ground-up parts refined into the good stuff."
	color = "#770000"
	taste_description = "gore"

/datum/reagent/warmongers/medicine/slurry/on_mob_life(mob/living/carbon/M)
	for(var/obj/item/bodypart/bodypart as anything in M.bodyparts)
		if(bodypart.heal_damage(15, 20))
			M.update_damage_overlays()
		if(bodypart.heal_wounds(25))
			M.update_damage_overlays()
	M.adjustToxLoss(-10)
	M.adjustOxyLoss(-10)
	M.blood_volume += 25

	..()
	. = 1

/*
######### TOXINS
*/

/datum/reagent/warmongers/poison
    name = "Poison"
    description = "It kills you, probably."
    taste_description = "sweetness"
    color = "#49B960"

    var/toxpwr = 1.5
    var/silent_toxin = FALSE // Won't produce a pain message when processed by liver/life() if there isn't another non-silent toxin present
    
    // #define REAGENTS_EFFECT_MULTIPLIER (REAGENTS_METABOLISM / 0.4)
    // By defining the effect multiplier this way, it'll exactly adjust all effects according to how they originally were with the 0.4 metabolism

/datum/reagent/warmongers/poison/on_mob_life(mob/living/carbon/M)
	if(toxpwr)
		M.adjustToxLoss(toxpwr*REM, 0)
	return ..()

/datum/reagent/warmongers/poison/swampbile
    name = "Swamp Bile"
    description = "Horrid and putrid, you will regret eating this."
    taste_description = "bile"
    color = "#52641D"
    toxpwr = 3

/*
######### DRUGS
*/

/datum/reagent/warmongers/drug
    name = "Drugs"
    description = "You'll have a good time, probably."
    taste_description = "wildness"
    color = "#DC716E"

/*
######### ITEMS
*/

/obj/item/reagent_containers/glass/bottle/warmongers
	name = "Bottle of War"
	desc = "A label on it says to feed it to people suffering from NOT KILLING PEOPLE."
	list_reagents = list(/datum/reagent/warmongers = 100)

/obj/item/reagent_containers/glass/bottle/warmongers/rootjuice
	name = "Bottle of Rootjuice"
	desc = "Heals wounds and leaves a rooty aftertaste."
	list_reagents = list(/datum/reagent/warmongers/rootjuice = 100)

/obj/item/reagent_containers/glass/bottle/warmongers/slurry
	name = "Bottle of Slurry"
	desc = "A powerful medicine, but at what cost?"
	list_reagents = list(/datum/reagent/warmongers/slurry = 100)
