/obj/item/rogueweapon/surgery
	name = "surgical tool"
	desc = "Something that will tear your guts apart."
	icon = 'icons/roguetown/items/surgery.dmi'
	item_state = "bone_dagger"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	gripsprite = FALSE
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	force = 12
	throwforce = 12
	wdefense = 3
	wbalance = 1
	max_blade_int = 100
	max_integrity = 175
	thrown_bclass = BCLASS_CUT
	associated_skill = /datum/skill/combat/knives
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/surgery/Initialize()
	. = ..()
	item_flags |= SURGICAL_TOOL //let's not stab patients for fun

/obj/item/rogueweapon/surgery/scalpel
	name = "scalpel"
	desc = "A tool used to carve precisely into the flesh of the sickly."
	icon_state = "scalpel"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	tool_behaviour = TOOL_SCALPEL

/obj/item/rogueweapon/surgery/saw
	name = "saw"
	desc = "A tool used to carve through bone."
	icon_state = "bonesaw"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver)
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/bladed/bladedmedium (1).ogg','sound/combat/parry/bladed/bladedmedium (2).ogg','sound/combat/parry/bladed/bladedmedium (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshmed (1).ogg','sound/combat/wooshes/bladed/wooshmed (2).ogg','sound/combat/wooshes/bladed/wooshmed (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	force = 16
	throwforce = 16
	wdefense = 3
	wbalance = 1
	w_class = WEIGHT_CLASS_NORMAL
	thrown_bclass = BCLASS_CHOP
	tool_behaviour = TOOL_SAW

/obj/item/rogueweapon/surgery/hemostat
	name = "forceps"
	desc = "A tool used to clamp down on soft tissue."
	icon_state = "forceps"
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	tool_behaviour = TOOL_HEMOSTAT

/obj/item/rogueweapon/surgery/retractor
	name = "speculum"
	desc = "A tool used to spread tissue open for surgical access."
	icon_state = "speculum"
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	wdefense = 3
	wbalance = 1
	w_class = WEIGHT_CLASS_NORMAL
	thrown_bclass = BCLASS_BLUNT
	tool_behaviour = TOOL_RETRACTOR

/obj/item/rogueweapon/surgery/bonesetter
	name = "bone forceps"
	desc = "A tool used to clamp down on hard tissue."
	icon_state = "bonesetter"
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	tool_behaviour = TOOL_BONESETTER

/obj/item/rogueweapon/surgery/cautery
	name = "cautery iron"
	desc = "A tool used to cauterize wounds. Heat it up before use."
	icon_state = "cauteryiron"
	possible_item_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED
	force = 18
	throwforce = 18
	wdefense = 3
	wbalance = -1
	associated_skill = /datum/skill/combat/axesmaces
	sharpness = IS_BLUNT
	w_class = WEIGHT_CLASS_NORMAL
	thrown_bclass = BCLASS_BLUNT
	/// Timer to cool down
	var/cool_timer
	/// Whether or not we are heated up
	var/heated = FALSE

/obj/item/rogueweapon/surgery/cautery/examine(mob/user)
	. = ..()
	if(heated)
		. += "<span class='warning'>The tip is hot to the touch.</span>"

/obj/item/rogueweapon/surgery/cautery/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	if(heated)
		icon_state = "[initial(icon_state)]_hot"

/obj/item/rogueweapon/surgery/cautery/pre_attack(atom/A, mob/living/user, params)
	if(!istype(user.a_intent, /datum/intent/use))
		return ..()
	var/heating = 0
	if(istype(A, /obj/machinery/light/rogue))
		var/obj/machinery/light/rogue/forge = A
		if(forge.on)
			heating = 20
	if(heating)
		user.visible_message("<span class='info'>[user] heats [src].</span>")
		fire_act(heating)
		return TRUE
	return ..()

/obj/item/rogueweapon/surgery/cautery/fire_act(added, maxstacks)
	. = ..()
	if(!heated)
		playsound(src, 'sound/items/firelight.ogg', 100, vary = TRUE)
	update_heated(TRUE)
	if(cool_timer)
		deltimer(cool_timer)
	cool_timer = addtimer(CALLBACK(src, PROC_REF(update_heated), FALSE), added SECONDS, TIMER_STOPPABLE)

/obj/item/rogueweapon/surgery/cautery/get_temperature()
	if(heated)
		return FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	return ..()

/obj/item/rogueweapon/surgery/cautery/proc/update_heated(new_heated)
	heated = new_heated
	if(heated)
		damtype = BURN
	else
		damtype = BRUTE
	update_icon()

/obj/item/rogueweapon/surgery/hammer
	name = "examination hammer"
	desc = "A hammer used to check a patient's reactions and diagnose their condition, might make a good weapon aswell..."
	icon_state = "kneehammer"
	possible_item_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED
	force = 30
	throwforce = 8
	wdefense = 3
	wbalance = -1
	associated_skill = /datum/skill/misc/medicine // Time to practice medicine...
	sharpness = IS_BLUNT
	w_class = WEIGHT_CLASS_NORMAL
	thrown_bclass = BCLASS_BLUNT

/obj/item/rogueweapon/surgery/hammer/pre_attack(atom/A, mob/living/user, params)
	if(!istype(user.a_intent, /datum/intent/use))
		return ..()
	if(user.mind.get_skill_level(/datum/skill/misc/medicine) < 1)
		to_chat(user, "<span class='warning'>I doubt I could use this. Might make a good weapon, though.</span>")
		return ..()
	if(ishuman(A))
		if(A == user)
			user.visible_message("<span class='info'>[user] begins smacking themself with a small hammer.</span>")
		else
			user.visible_message("<span class='info'>[user] begins to smack [A] with a small hammer.</span>")
		if(do_after(user, 5 SECONDS, target = A))
			A.visible_message("<span class='info'>[A] jerks their knee after the hammer strikes!</span>")
			if(prob(1))
				playsound(user, 'sound/misc/bonk.ogg', 100, FALSE, -1)
			var/mob/living/carbon/human/human_target = A
			human_target.check_for_injuries(user)
	return ..()

/obj/item/rogueweapon/surgery/limbgrabber
	name = "ultra-stitcher"
	desc = "The Ultra-Stitcher powered by LimbSpike technologies. Contrary to popular belief, does not actually stitch anything unless used for limb transplants."
	icon_state = "clamper"
	possible_item_intents = list(/datum/intent/use, /datum/intent/dagger/thrust)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	thrown_bclass = BCLASS_BULLET // LOL
	embedding = list("embedded_unsafe_removal_time" = 10, "embedded_pain_chance" = 60, "embedded_pain_multiplier" = 2, "embed_chance" = 100, "embedded_fall_chance" = 10)
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	var/obj/item/bodypart/grabbed
	var/dosage = 10 // in oz, not units. to go back to units, multiply by 3
					// the formula to get oz from units is round(X / 3)

/obj/item/rogueweapon/surgery/limbgrabber/on_embed_life(mob/living/user, obj/item/bodypart/bodypart)
	. = ..()
	if(reagents.total_volume)
		if(user.reagents)
			reagents.reaction(user, INJECT, reagents.total_volume)
			reagents.trans_to(user, reagents.total_volume)

/obj/item/rogueweapon/surgery/limbgrabber/examine(mob/user)
	. = ..()
	. += "<span class='info'>The current dosage is [dosage] oz.</span>"
	if(grabbed)
		. += "<span class='info'>It is currently loaded with \a [grabbed].</span>"
	. += "<span class='tutorial'>Click a limb on the ground with it in hand to LimbSpike it.</span>"
	. += "<span class='tutorial'>Click a patient while targeting the lost limb to rapidly transplant it.</span>"
	. += "<span class='tutorial'>It can be filled with chemicals and/or medicine to inject the patient with when transplanting them.</span>"
	. += "<span class='tutorial'>Right-click to change dosage. The device can only hold 10 oz of medicine.</span>"
	. += "<span class='tutorial'>You do not have to perform a limb transplant to inject chemicals into a patient.</span>"

/obj/item/rogueweapon/surgery/limbgrabber/Initialize()
	. = ..()
	create_reagents(30, OPENCONTAINER)
	item_flags -= SURGICAL_TOOL //LET'S stab patients for fun
								// no, but in all seriousness if we dont remove it the behavior is all fucky.

/obj/item/rogueweapon/surgery/limbgrabber/proc/dosage(mob/user)
	var/input = input(user, "Input dosage in ounces (oz).", "WARMONGERS", dosage) as num
	input = round(input)
	if(input > reagents.maximum_volume)
		to_chat(user, "<span class='warning'>THAT CAN'T BE DONE!</span>")
		return
	dosage = input
	to_chat(user, "<span class='info'>It is done! The dosage is now [dosage] oz.</span>")
	playsound(src, 'sound/misc/keyboard_enter.ogg', 75, FALSE, -3)

/obj/item/rogueweapon/surgery/limbgrabber/attack_right(mob/user)
	dosage(user)

/obj/item/rogueweapon/surgery/limbgrabber/rmb_self(mob/user)
	dosage(user)

/obj/item/rogueweapon/surgery/limbgrabber/attack_self(mob/user)
	if(grabbed)
		to_chat(user, "<span class='info'>I drop the limb.</span>")

		grabbed.forceMove(user.drop_location())
		grabbed.pixel_x = 0
		grabbed.pixel_y = 0

		grabbed = null
		update_icon()
	else
		. = ..()

/obj/item/rogueweapon/surgery/limbgrabber/attack(mob/living/M, mob/living/user)
	if(!istype(user.a_intent, /datum/intent/use))
		return ..()
	if(!ishuman(M))
		to_chat(user, "<span class='warning'>...What?</span>")
		return
	var/mob/living/carbon/human/H = M

	H.flash_fullscreen("redflash1")
	if(grabbed)
		if(!check_zone(user.zone_selected) == grabbed.body_zone)
			to_chat(user, "<span class='warning'>...Where the fuck am I looking at?</span>")
			return
		if(H.get_bodypart(check_zone(user.zone_selected)))
			to_chat(user, "<span class='warning'>They already have a limb there.</span>")
			return
		if(grabbed.attach_limb(H, TRUE) && grabbed.attach_wound)
			grabbed.add_wound(grabbed.attach_wound)
		grabbed = null
		
		update_icon()
		playsound(get_turf(user), 'sound/misc/inject.ogg', 100, FALSE, -1)
		playsound(get_turf(user), 'sound/foley/sewflesh.ogg', 65, TRUE, -1)
		to_chat(user, "<span class='info'>Transplant success! I inject the surely life-saving medication as well.</span>")

		if(reagents.total_volume)
			if(H.reagents)
				reagents.reaction(H, INJECT, dosage)
				reagents.trans_to(H, dosage, transfered_by = user)
	else
		playsound(get_turf(user), 'sound/misc/inject.ogg', 65, FALSE, -1)
		to_chat(user, "<span class='info'>I disregard the warning label and use the ultra-stitcher to inject medicine.</span>")
		if(reagents.total_volume)
			if(H.reagents)
				reagents.reaction(H, INJECT, dosage)
				reagents.trans_to(H, dosage, transfered_by = user)

/obj/item/rogueweapon/surgery/limbgrabber/pre_attack(atom/A, mob/living/user, params)
	if(!istype(user.a_intent, /datum/intent/use))
		return ..()
	/*
	if(user.mind.get_skill_level(/datum/skill/misc/medicine) < 1)
		to_chat(user, "<span class='warning'>Wouldn't wanna stab myself.</span>")
		return
	*/

	if(istype(A, /obj/item/bodypart))
		if(grabbed)
			to_chat(user, "<span class='warning'>I'm afraid I already have a cadaver.</span>")
			return
		var/obj/item/bodypart/BP = A
		grabbed = BP
		BP.forceMove(src)

		playsound(get_turf(src), pick(list('sound/combat/hits/bladed/genthrust (1).ogg','sound/combat/hits/bladed/genthrust (2).ogg',)), 75, FALSE, -1)
		update_icon()
	else
		return ..()

/obj/item/rogueweapon/surgery/limbgrabber/update_icon()
	. = ..()
	cut_overlays()
	if(grabbed)
		grabbed.pixel_x = 10
		grabbed.pixel_y = 0
		grabbed.transform = null

		var/image/img = image("icon"=grabbed, "layer"=FLOAT_LAYER)
		img.plane = FLOAT_PLANE
		add_overlay(img)