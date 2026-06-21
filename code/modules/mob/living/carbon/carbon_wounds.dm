/mob/living/carbon/get_embedded_objects()
	. = ..()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(!length(bodypart.embedded_objects))
			continue
		. += bodypart.embedded_objects

/mob/living/carbon/get_wounds()
	. = ..()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(!length(bodypart.wounds))
			continue
		. += bodypart.wounds

/mob/living/carbon/get_critical_wounds()
	var/list/critical_wounds = list()
	var/list/wounds = list()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		wounds += bodypart.wounds
	for(var/datum/wound/W in wounds)
		if(W.critical)
			critical_wounds += W
	return critical_wounds