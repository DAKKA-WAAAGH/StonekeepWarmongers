//Achievements system by Matt ported from IS12 Warfare codebase. Never beating the IS12 but in fantasy setting, are we? Fuck.
//This system allows you there to be achievements in the game, that are not tied to a database or to the byond medals system
//User mob.unlock_achievement(new/datum/achievement/achievement()) or client.unlock_achievement(new/datum/achievement/achievement())
//Check achievements.dm for the list of achievements.

//Defines for client.
/client
	var/datum/achievements/achievement_holder = null

//The achievement holder datum
/datum/achievements
	var/list/achievements = list()

/client/New()
	achievement_holder = new
	..()

//The actual achievements
/datum/achievement
	var/name = "Default Achievement"
	var/description = "Default Description"
	var/difficulty = DIFF_EASY
	var/announced = FALSE

/client/proc/unlock_achievement(var/datum/achievement/A)
	if(IsGuestKey(ckey))
		return
	for(var/X in achievement_holder.achievements)
		var/datum/achievement/AA = X
		if(istype(A, AA.type))
			return
	achievement_holder.achievements |= A
	var/savefile/F = new /savefile("data/player_saves/[copytext(ckey, 1, 2)]/[ckey]/achievements.sav")//Store the achievemnt in the file.
	achievement_holder.Write(F)
	var/H
	switch(A.difficulty)
		if (DIFF_MEDIUM)
			H = "#EE9A4D"
		if (DIFF_EASY)
			H = "green"
		if (DIFF_HARD)
			H = "red"
	if (A.announced)
		to_chat(world, "<b>Achievement Unlocked! [ckey] unlocked the '<font color = [H]>[A.name]</font color>' achievement.</b></font>")
	else
		to_chat(src, "<b>Achievement Unlocked! You unlocked the '<font color = [H]>[A.name]</font color>' achievement.</b></font>")
	mob.playsound_local(get_turf(mob), 'sound/achievement.ogg', 70, FALSE, pressure_affected=FALSE)
	if(A.description)
		to_chat(src, "<i>[A.description]</i>")

/mob/proc/unlock_achievement(var/datum/achievement/A)// use is 	mob.unlock_achievement(new/datum/achievement/achievement())
	if(client)
		client.unlock_achievement(A)

/mob/verb/show_achievements()
	set name = "Show Achievements"
	set category = "Control"

	if(!client)//How they check achievements without client? No idea. But I'm staying sane.
		return

	if(IsGuestKey(ckey)) //How did they even connect without being logged in? No idea. But better safe than sorry.
		to_chat(src, "<b>Guests don't get achievements.</b>")
		return

	var/count = 0
	var/list/achievements = list()
	achievements += "<b>Achievements:</b>\n"

	for(var/X in client.achievement_holder.achievements)
		if(isnull(X))
			client.achievement_holder.achievements -= X
			continue
		var/datum/achievement/A = X //Typeless loops are faster than typed ones. Or os TG told me anyway. *shrug*
		var/H
		count++
		switch(A.difficulty)
			if (DIFF_MEDIUM)
				H = "#EE9A4D"
			if (DIFF_EASY)
				H = "green"
			if (DIFF_HARD)
				H = "red"
		achievements += "<b>[count]:<font color = [H]> [A.name]</font color></b></font>\n"
		if(A.description)
			achievements += "<i>[A.description]</i>\n"
		else
			achievements += "\n"
	if(count)
		achievements += "---\n<b>TOTAL ACHIEVEMENTS: [count]</b>"
	else
		achievements += "<i>You have zero achievements in your line of duty... yet.</i>"

	to_chat(src, examine_block("<span class='info'>[achievements.Join()]</span>"))