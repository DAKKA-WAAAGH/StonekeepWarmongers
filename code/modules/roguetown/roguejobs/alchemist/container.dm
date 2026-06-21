// Alright. I'm sorting this shit now because Zeth is either a fucking sociopath or incompetent when it comes to tagging.

/obj/item/reagent_containers/glass/bottle/rogue
	desc = "Luckily for the shoeless, it's sugar glass! Yummy. Don't eat it though, it's only 95% sugar glass. That 5% can FUCK you up."

/obj/item/reagent_containers/glass/bottle/rogue/examine(mob/user)
	. = ..()
	. += "<span class='tutorial'>If it is uncorked then it can be thrown to release it's contents into the surroundings.</span>"
	. += "<span class='tutorial'>Right-click to uncork.</span>"

/obj/item/reagent_containers/glass/bottle/rogue/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(closed)
		return
	if(ishuman(throwingdatum.thrower))
		var/mob/living/carbon/human/thrower = throwingdatum.thrower
		var/list/humans = list()
		var/list/all_humans = list()
		var/turf/T = get_turf(src)
		for(var/mob/living/carbon/human/H in viewers(3, T))
			all_humans += H
			if(H.stat != DEAD && H.reagents && H.warfare_faction == thrower.warfare_faction)
				humans += H
				
		for(var/obj/effect/hotspot/hotspot in viewers(3,T))
			qdel(hotspot)

		if(!length(humans))
			return ..()

		var/amount_per_person = reagents.total_volume / length(humans)
		amount_per_person = round(amount_per_person, 0.1)

		for(var/mob/living/carbon/human/HU in all_humans)
			HU.adjust_fire_stacks(-2.5)
			HU.ExtinguishMob()
			if(HU.stat == DEAD && HU.on_fire)
				HU.dust()

		for(var/mob/living/carbon/human/H in humans)
			var/obj/effect/particle_effect/smoke/S = new(get_turf(T))
			S.color = mix_color_from_reagents(reagents.reagent_list)
			S.alpha = rand(50,125)

			var/image/I = image('icons/effects/effects.dmi', H, "smoke", ABOVE_MOB_LAYER)
			I.color = mix_color_from_reagents(reagents.reagent_list)
			flick_overlay_view(I, H, 30)
		
			var/matrix/M = matrix()
			M.Scale(2,2)
			
			reagents.trans_to(H, amount_per_person, transfered_by = thrower)

			animate(I, 30, alpha = 0, transform = M)
		
		new /obj/effect/decal/cleanable/glass(T)

		playsound(T, 'sound/items/firesnuff.ogg', 75)

		qdel(src)
		return

//////////////////////////
/// ALCHEMICAL POTIONS ///
//////////////////////////

/obj/item/reagent_containers/glass/bottle/rogue/healthpot
	name = "bottle of health"
	desc = "A label on it says to feed it to people suffering from their guts leaving their body. Quite spectacular."
	list_reagents = list(/datum/reagent/medicine/healthpot = 72)

/obj/item/reagent_containers/glass/bottle/rogue/manapot
	list_reagents = list(/datum/reagent/medicine/manapot = 45)

/obj/item/reagent_containers/glass/bottle/rogue/poison
	list_reagents = list(/datum/reagent/toxin/killersice = 1)

/obj/item/reagent_containers/glass/bottle/rogue/water
	list_reagents = list(/datum/reagent/water = 45) // Fuck you water is a alch-thing.


//////////////////////////
/// ALCOHOLIC BOTTLES ///
//////////////////////////

// BEER - Cheap, Plentiful, Saviours of Family Life
/obj/item/reagent_containers/glass/bottle/rogue/beer
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 45)
	desc = "A bottle that contains a generic small-bier. It has an improvised corkseal made of hardened clay."

/obj/item/reagent_containers/glass/bottle/rogue/beer/spottedhen
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/spottedhen = 45)
	desc = "A bottle with a spotted-hen cork-seal. An extremely cheap lagar hailing from a local brewery."

/obj/item/reagent_containers/glass/bottle/rogue/beer/blackgoat
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/blackgoat = 45)
	desc = "A bottle with a black goat cork-seal. A fruit-sour bier brewed with jackberries for a tangy taste."

/obj/item/reagent_containers/glass/bottle/rogue/beer/hagwoodbitter
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/hagwoodbitter = 45)
	desc = "A bottle with a hagwood bitters cork-seal. Its brewery no longer exists, these bottles are all that remains."

/obj/item/reagent_containers/glass/bottle/rogue/beer/aurorian
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/aurorian = 45)
	desc = "A bottle with a aurorian brewhouse cork-seal. Not of humin make."

/obj/item/reagent_containers/glass/bottle/rogue/beer/butterhairs
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/butterhairs = 45)
	desc = "A bottle with a very strange cork-seal. This bier, known as butterhairs: is widely considered one of the great biers lost to time."

/obj/item/reagent_containers/glass/bottle/rogue/beer/stonebeardreserve
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/stonebeards = 45)
	desc = "A bottle with what appears to be the cork-seal of a once great people. One of the rarest and most expensive biers ever produced. Some will murder just for a thimble of the stuff."

// WINES - Expensive, Nobleblooded
/obj/item/reagent_containers/glass/bottle/rogue/wine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 45)
	desc = "High class, Full-Lifer wine, brewed and exported from the heartland of the Regime."

/obj/item/reagent_containers/glass/bottle/rogue/wine/sourwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/sourwine = 45)
	desc = "A bottle that contains a classic from the land of Grenn with a black ink cork-seal.. An extremely sour wine that is watered down with mineral water."

/obj/item/reagent_containers/glass/bottle/rogue/wine/waterwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/waterwine = 45)
	desc = "The only thing No-lifers are legally allowed to drink that contains any alcohol. Extremely watered down."

/obj/item/reagent_containers/glass/bottle/rogue/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/redwine = 45)
	desc = "A bottle with the Valorfort cork-seal. This one appears to be labelled as a relatively young red-wine from the devastated state."

/obj/item/reagent_containers/glass/bottle/rogue/whitewine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/whitewine = 45)
	desc = "A bottle with the Valorfort cork-seal. This one appears to be labelled as a sweet wine from the colder northern regions."

/obj/item/reagent_containers/glass/bottle/rogue/elfred
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/elfred = 45)
	desc = "A bottle gilded with a silver cork-seal. No one, not even those from Valorfort itself, knows how this is made."

/obj/item/reagent_containers/glass/bottle/rogue/elfblue
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/elfblue = 45)
	desc = "A bottle gilded with a golden cork-seal. There is no way any mortal being could create something such as this."
