/datum/warmode
	var/name = "WARMONGERS Gamemode"
	var/shorthand = "WRMNGS"
	var/blurb = "Uh oh."

	var/obj/structure/warobjective/objective

	var/mob/living/carbon/human/winner
	var/winner_name = null

	var/alertsound = 'sound/misc/alert.ogg'
	var/haloalertsound = 'sound/misc/alert.ogg'

/datum/warmode/proc/beginround()
	if(istype(SSticker.mode, /datum/game_mode/warmongers))
		to_chat(world, "<span class='danger'>[blurb]</span>")
		if(aspect_chosen(/datum/round_aspect/halo))
			SEND_SOUND(world, haloalertsound)
		else
			for(var/mob/living/carbon/human/M in GLOB.player_list)
				SEND_SOUND(M, 'sound/misc/warstart.ogg')

/datum/warmode/Destroy()
	. = QDEL_HINT_IWILLGC
	STOP_PROCESSING(SSprocessing, src)
	..()

/datum/warmode/lords
	name = "Lord Destruction"
	shorthand = "LD"
	blurb = "Take the enemy Lord's crown and sit on the Throne of Heartfelt!"
	winner_name = "crownbearer"
	haloalertsound = 'sound/vo/halo/hail2theking.mp3'

/datum/warmode/noreturn
	name = "Capture the Flag"
	shorthand = "CTF"
	haloalertsound = 'sound/vo/halo/ctf.mp3'
	blurb = "Capture the enemy flag and take it to your PONR!"

	winner_name = "capturer"

	var/wealreadywon = FALSE

	var/mob/living/carbon/human/blu_flag
	var/mob/living/carbon/human/red_flag

	var/blu_captures = 0 // how many times the blu team has captured the red teams flags
	var/red_captures = 0

	var/captures_required = 3 // captures required to win the game. you win at 3.

/datum/warmode/tdm
	name = "Last Stand"
	shorthand = "TDM"
	
	var/stalemate_kills = 98
	var/win_kills = 50
	var/base_player_count = 16

	var/min_win_kills = 10
	var/max_win_kills = 200
	var/min_stalemate_kills = 20
	var/max_stalemate_kills = 400

/datum/warmode/tdm/beginround()
	var/player_count = length(GLOB.clients)
	win_kills = clamp(round(50 * (player_count / base_player_count)), min_win_kills, max_win_kills)
	stalemate_kills = clamp(round(98 * (player_count / base_player_count)), min_stalemate_kills, max_stalemate_kills)

	START_PROCESSING(SSprocessing, src)
	blurb = "Secure [win_kills] kills for your team to win!"

	..()

/datum/warmode/tdm/process()
	if(istype(SSticker.mode, /datum/game_mode/warmongers))
		var/datum/game_mode/warmongers/C = SSticker.mode
		if(SSticker.regime_deaths >= win_kills)
			C.do_war_end(null, RED_WARTEAM)
			STOP_PROCESSING(SSprocessing, src)
		if(SSticker.unionist_deaths >= win_kills)
			C.do_war_end(null, BLUE_WARTEAM)
			STOP_PROCESSING(SSprocessing, src)
		if(SSticker.deaths >= stalemate_kills)
			C.do_war_end()
			STOP_PROCESSING(SSprocessing, src)

/datum/warmode/assault
	name = "Assault"
	shorthand = "ASLT"
	objective = /obj/structure/warobjective/assaultthrone

	var/attack_progress = 0
	var/current_capture_point = 1
	var/base_player_count = 8

	var/blu_spawns = 30
	var/min_blu_spawns = 10
	var/max_blu_spawns = 30

	var/list/capture_points = list()
	var/list/showers = list()
	var/total_capture_points = 0

/datum/warmode/assault/beginround()
	var/datum/game_mode/warmongers/C = SSticker.mode
	var/player_count = length(C.unionists) // It's based on enemy count because well... unionists kill regimians
	blu_spawns = clamp(round(50 * (player_count / base_player_count)), min_blu_spawns, max_blu_spawns)

	START_PROCESSING(SSprocessing, src)
	blurb = "The Regime must capture both points! The PPU must defend! THE REGIME GETS ONLY [blu_spawns] AVAILABLE SOLDIERS, DEATH IS BAD!!!"

	for(var/area/rogue/assault/cp in world)
		if(istype(cp))
			capture_points += cp
			total_capture_points++
	for(var/obj/effect/landmark/assaultrespawn/defender/DDD)
		if(DDD.respawn_id == "first") // I'm going to kill myself.
			SSwarmongers.landmark_respawn_id_defender = "first"
	..()

/datum/warmode/assault/process()
	if(istype(SSticker.mode, /datum/game_mode/warmongers))
		var/datum/game_mode/warmongers/C = SSticker.mode
		if(SSticker.regime_deaths >= blu_spawns)
			C.do_war_end(null, RED_WARTEAM)
			STOP_PROCESSING(SSprocessing, src)
		if(current_capture_point > total_capture_points)
			C.do_war_end(null, BLUE_WARTEAM)
			STOP_PROCESSING(SSprocessing, src)

/area/rogue/assault
	name = "Capture Point"
	safe_from_mortar = TRUE
	var/list/grenz = list()
	var/list/heart = list()
	var/capture_sound = 'sound/misc/stolen.ogg'
	var/capture_rate = 1 // 1 means normal speed, 2 means two times speed.
	var/tocapture_points = 100 // How much points to capture?
	var/holder = RED_WARTEAM
	var/capture_order = 0
	var/capturable = FALSE

	var/warned = FALSE // You only get one warning you filthy bitch

	var/respawn_id_on_cap_attacker // Use a landmark with this ID
	var/respawn_id_on_cap_defender

/area/rogue/assault/proc/on_capture(var/team = BLUE_WARTEAM)
	return

/area/rogue/assault/on_capture(team)
	. = ..()
	var/datum/game_mode/warmongers/C = SSticker.mode
	if(!C?.warmode)
		return
	var/datum/warmode/assault/ASR = C.warmode
	
	if(ASR.current_capture_point > ASR.total_capture_points)
		for(var/mob/living/carbon/human/H in src)
			if(HAS_TRAIT(H, TRAIT_NOBLE))
				H.unlock_achievement(new /datum/achievement/respected_captain())

/area/rogue/assault/New()
	. = ..()
	START_PROCESSING(SSprocessing, src)

	// Set the first point as capturable
	if(capture_order == 1)
		capturable = TRUE

/area/rogue/assault/process()
	var/datum/game_mode/warmongers/C = SSticker.mode
	if(!C?.warmode)
		return

	if(!istype(C.warmode, /datum/warmode/assault))
		STOP_PROCESSING(SSprocessing, src)
		return

	var/datum/warmode/assault/ASS = C.warmode

	// Capture order check
	capturable = (capture_order == ASS.current_capture_point)

	for(var/mob/living/carbon/human/H in src)
		if(H.stat == CONSCIOUS && H.client)
			if(H.warfare_faction == BLUE_WARTEAM)
				grenz |= H
				heart -= H
			else if(H.warfare_faction == RED_WARTEAM)
				heart |= H
				grenz -= H
		else
			grenz -= H
			heart -= H

	for(var/mob/living/carbon/human/H in grenz) // my last fucking idea for this, because it just refuses to remove people from lists. if this doesnt work, im considering removing the gamemode all together
		if(get_area(H) != src)
			grenz -= H
	for(var/mob/living/carbon/human/H in heart)
		if(get_area(H) != src)
			heart -= H

	if(capturable)
		if(grenz.len > heart.len)
			if(ASS.attack_progress < tocapture_points)
				ASS.attack_progress += 1 * capture_rate
		else if(grenz.len < heart.len)
			if(ASS.attack_progress > 0)
				ASS.attack_progress -= capture_rate

		if(ASS.attack_progress >= tocapture_points && (holder != BLUE_WARTEAM))
			to_chat(world, "<span class='userdanger'>[uppertext("[BLUE_WARTEAM] HAVE CAPTURED THE [src]")]!</span>")
			holder = BLUE_WARTEAM

			C.blu_bonus += 1
			C.red_bonus += 3 // They're gonna need it for the final defenses.

			ASS.attack_progress = 0
			ASS.blu_spawns += 10 // To help incentivize unionists to not just sit on their ass doing nothing
			on_capture(holder)
			SEND_SOUND(world, capture_sound)
			ASS.current_capture_point++

			for(var/client/regis in C.regimians)
				var/atom/movable/screen/navigate_arrow/NVA = locate() in regis.screen
				if(NVA)
					for(var/obj/structure/capturepoint_shower/shower in ASS.showers)
						if(shower.assault.capture_order == ASS.current_capture_point || shower.assault.capture_order == 0)
							NVA.thing = get_turf(shower)

			if(respawn_id_on_cap_attacker)
				SSwarmongers.landmark_respawn_id_attacker = respawn_id_on_cap_attacker
			if(respawn_id_on_cap_defender)
				SSwarmongers.landmark_respawn_id_defender = respawn_id_on_cap_defender

/area/rogue/assault/Entered(atom/movable/M)
	. = ..()
	var/datum/game_mode/warmongers/C = SSticker.mode
	if(!istype(C?.warmode, /datum/warmode/assault))
		return
	var/datum/warmode/assault/ASS = C.warmode // hehe
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!capturable && H.warfare_faction != holder)
			if(capture_order < ASS.current_capture_point)
				to_chat(H, "<span class='warning'>[src] has been already captured!</span>")
			else
				to_chat(H, "<span class='warning'>[src] can't be captured yet!</span>")
		else if(H.warfare_faction != holder)
			to_chat(H, "<span class='tutorial'>Capturing [src]!</span>")

			if(!warned)
				warned = TRUE
				for(var/client/client in C.unionists)
					to_chat(client, "<span class='userdanger'>[uppertext("ATTENTION! THE [BLUE_WARTEAM] ARE CAPTURING THE [src]")]!</span>")
					SEND_SOUND(client, 'sound/misc/control_points.ogg')
		else
			to_chat(H, "<span class='tutorial'>Defending [src]!</span>")

/area/rogue/assault/Exit(mob/living/M)
	. = ..()
	if(ishuman(M))
		if(M in grenz)
			grenz -= M
		else if(M in heart)
			heart -= M
			to_chat(M, "<span class='info'>Are you sure? Leaving it unattended is a horrible idea. Most of the time.</span>")

/area/rogue/indoors/airship
	name = "reinforcement airship"
	ambientrain = RAIN_IN
	ambientsounds = 'sound/ambience/airship_ambience.ogg'
	ambientnight = 'sound/ambience/airship_ambience.ogg'
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/ambience/airship_ambience.ogg'
	droning_sound_dusk = 'sound/ambience/airship_ambience.ogg'
	droning_sound_night = 'sound/ambience/airship_ambience.ogg'

/area/rogue/indoors/airship/Entered(mob/living/M, atom/OldLoc)
	. = ..()
	to_chat(M, "<span class='info'>Be patient and await arrival to the battlefield. Chat with your fellow comrades.</span>")

/area/rogue/indoors/airship/red
	icon_state = "red"

/area/rogue/indoors/airship/blue
	icon_state = "blue"

// BLOODFORT

/area/rogue/assault/throneroom
	name = "Thronesroom"
	droning_sound = 'sound/music/firstwhistle.ogg'
	droning_sound_dusk = 'sound/music/firstwhistle.ogg'
	droning_sound_night = 'sound/music/firstwhistle.ogg'

	capture_rate = 5 // might eb too much. 1 second to capture or something idk im not a math guy
	tocapture_points = 100 // 20 seconds to capture

	capture_order = 2

/area/rogue/assault/gates
	name = "Gateshouse"
	droning_sound = 'sound/music/firstwhistle.ogg'
	droning_sound_dusk = 'sound/music/firstwhistle.ogg'
	droning_sound_night = 'sound/music/firstwhistle.ogg'

	capture_rate = 2
	tocapture_points = 100 // 50 seconds to capture if my math is correct

	capture_order = 1

// BDAY

/area/rogue/assault/waterfort
	name = "Waterfort"
	droning_sound = 'sound/music/firstwhistle.ogg'
	droning_sound_dusk = 'sound/music/firstwhistle.ogg'
	droning_sound_night = 'sound/music/firstwhistle.ogg'

	capture_rate = 2
	tocapture_points = 100 // 50 seconds to capture if my math is correct

	capture_order = 1
	respawn_id_on_cap_attacker = "Watershouse"