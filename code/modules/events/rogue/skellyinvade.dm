/datum/round_event_control/rogue/skellyinvade
	name = "Skeleton Invasion"
	typepath = /datum/round_event/rogue/skellyinvade
	weight = 10
	max_occurrences = 999
	min_players = 0
	req_omen = TRUE
	todreq = list("night")

/datum/round_event/rogue/skellyinvade
	announceWhen	= 50
	var/spawncount = 3
	var/list/starts

/datum/round_event_control/rogue/skellyinvade/canSpawnEvent()
	if(!LAZYLEN(GLOB.round_aspect_spawners))
		return FALSE

/datum/round_event/rogue/skellyinvade/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)
//	var/maxi = max(GLOB.badomens.len, 1)
//	spawncount = 3 + maxi

/datum/round_event/rogue/skellyinvade/start()
	if(LAZYLEN(GLOB.round_aspect_spawners))
		for(var/i in 1 to spawncount)
			var/obj/effect/landmark/events/aspect_spawners/_T = pick_n_take(GLOB.round_aspect_spawners)
			if(_T)
				_T = get_turf(_T)
				if(isfloorturf(_T))
					new /mob/living/carbon/human/species/skeleton/npc(_T)

	return