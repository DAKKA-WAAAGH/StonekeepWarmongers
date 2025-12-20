/*

	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl


	Notice: This all gets automatically compiled in a list in dna.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/
/proc/init_sprite_accessory_subtypes(prototype, list/L, list/male, list/female,roundstart = FALSE)//Roundstart argument builds a specific list for roundstart parts where some parts may be locked
	if(!istype(L))
		L = list()
	if(!istype(male))
		male = list()
	if(!istype(female))
		female = list()

	for(var/path in subtypesof(prototype))
		if(roundstart)
			var/datum/sprite_accessory/P = path
			if(initial(P.locked))
				continue
		var/datum/sprite_accessory/D = new path()

		if(D.icon_state)
			L[D.name] = D
		else
			L += D.name

		switch(D.gender)
			if(MALE)
				male += D.name
			if(FEMALE)
				female += D.name
			else
				male += D.name
				female += D.name
	return L

/datum/sprite_accessory
	var/icon			//the icon file the accessory is located in
	var/icon_state		//the icon_state of the accessory
	var/name			//the preview name of the accessory
	var/gender = NEUTER	//Determines if the accessory will be skipped or included in random hair generations
	var/gender_specific //Something that can be worn by either gender, but looks different on each
	var/use_static		//determines if the accessory will be skipped by color preferences
	var/color_src = MUTCOLORS	//Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
	var/hasinner		//Decides if this sprite has an "inner" part, such as the fleshy parts on ears.
	var/locked = FALSE		//Is this part locked from roundstart selection? Used for parts that apply effects
	var/dimension_x = 32
	var/dimension_y = 32
	var/center = FALSE	//Should we center the sprite?
	var/list/specuse = list("human") //what species can use dis
	var/additional = FALSE //added hairbands/metal in hair/beards
	var/offsetti = FALSE
	var/roundstart = TRUE
	var/under_layer = FALSE

//////////////////////
// Hair Definitions //
//////////////////////
/datum/sprite_accessory/hair
	icon = 'icons/roguetown/mob/hair.dmi'	  // default icon for all hairs

	// please make sure they're sorted alphabetically and, where needed, categorized
	// try to capitalize the names please~
	// try to spell
	// you do not need to define _s or _l sub-states, game automatically does this for you

/datum/sprite_accessory/hair/baldn
	name = "Bald"
	icon_state = "hair_bald"
	specuse = list("standard", "fat")
	gender = MALE

/datum/sprite_accessory/hair/skinheadn
	name = "Shaved"
	icon_state = "hair_skinhead"
	specuse = list("standard", "fat")
	gender = MALE
	under_layer = TRUE

/datum/sprite_accessory/hair/mponytailn
	name = "Tied"
	icon_state = "hair_ponytail"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/heroicn
	name = "Heroic"
	icon_state = "hair_business2"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/noblen
	name = "Noble"
	icon_state = "hair_business"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/mohawkn
	name = "Berserker"
	icon_state = "hair_shavedmohawk"
	gender = MALE
	specuse = list("standard", "fat")
	under_layer = TRUE

/datum/sprite_accessory/hair/bedheadn
	name = "Helmet Hair"
	icon_state = "hair_bedhead"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/bowlcutn
	name = "Bowlcut"
	icon_state = "hair_bowlcut2"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fathern
	name = "Forged"
	icon_state = "hair_father"
	gender = MALE
	specuse = list("standard", "fat")
	under_layer = TRUE

/datum/sprite_accessory/hair/thinningn
	name = "Cavehead"
	icon_state = "hair_thinning"
	gender = MALE
	specuse = list("standard", "fat")
	under_layer = TRUE

/datum/sprite_accessory/hair/thinningrearn
	name = "Dome"
	icon_state = "hair_thinningrear"
	gender = MALE
	specuse = list("standard", "fat")
	under_layer = TRUE

/datum/sprite_accessory/hair/baldfaden
	name = "Scribe"
	icon_state = "hair_baldfade"
	gender = MALE
	specuse = list("standard", "fat")
	under_layer = TRUE

/datum/sprite_accessory/hair/mercn
	name = "Mercenary"
	icon_state = "hair_forelock"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/roguen
	name = "Rogue"
	icon_state = "hair_rogue"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/hair_tiedn
	name = "Tiedlong"
	icon_state = "hair_tied"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/hair_romanticn
	name = "Romantic"
	icon_state = "hair_romantic"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/hair_runtn
	name = "Runt"
	icon_state = "hair_runt"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/hair_sonn
	name = "Sun"
	icon_state = "hair_son"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/hair_bogn
	name = "Bog"
	icon_state = "hair_bog"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/hair_aristocratn
	name = "Aristocrat"
	icon_state = "hair_majestic"
	gender = MALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/baldb
	name = "Scalped"
	icon_state = "hair_baldb"
	specuse = list("bulky")
	gender = MALE

/datum/sprite_accessory/hair/skinheadb
	name = "Skinned"
	icon_state = "hair_skinheadb"
	specuse = list("bulky")
	gender = MALE
	under_layer = TRUE

/datum/sprite_accessory/hair/mponytailb
	name = "Tied Low"
	icon_state = "hair_ponytailb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/heroicb
	name = "Hero"
	icon_state = "hair_business2b"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/nobleb
	name = "Upstart"
	icon_state = "hair_businessb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/mohawkb
	name = "Brave"
	icon_state = "hair_shavedmohawkb"
	gender = MALE
	specuse = list("bulky")
	under_layer = TRUE

/datum/sprite_accessory/hair/bedheadb
	name = "Unkempt"
	icon_state = "hair_bedheadb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/bowlcutb
	name = "Bowl"
	icon_state = "hair_bowlcut2b"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fatherb
	name = "Anvil"
	icon_state = "hair_fatherb"
	gender = MALE
	specuse = list("bulky")
	under_layer = TRUE

/datum/sprite_accessory/hair/thinningb
	name = "Thinned"
	icon_state = "hair_thinningb"
	gender = MALE
	specuse = list("bulky")
	under_layer = TRUE

/datum/sprite_accessory/hair/thinningrearb
	name = "Skullcap"
	icon_state = "hair_thinningrearb"
	gender = MALE
	specuse = list("bulky")
	under_layer = TRUE

/datum/sprite_accessory/hair/baldfadeb
	name = "Balding"
	icon_state = "hair_baldfadeb"
	gender = MALE
	specuse = list("bulky")
	under_layer = TRUE

/datum/sprite_accessory/hair/mercb
	name = "Lock"
	icon_state = "hair_forelockb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/rogueb
	name = "Villain"
	icon_state = "hair_rogueb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/hair_tiedb
	name = "Tied Up"
	icon_state = "hair_tiedb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/hair_romanticb
	name = "Lowling"
	icon_state = "hair_romanticb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/hair_runtb
	name = "Tangle"
	icon_state = "hair_runtb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/hair_sonb
	name = "Son"
	icon_state = "hair_sonb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/hair_bogb
	name = "Boggard"
	icon_state = "hair_bogb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/hair_aristocratb
	name = "Lord"
	icon_state = "hair_majesticb"
	gender = MALE
	specuse = list("bulky")

/////////////////////////////
// GIRLY Hair Definitions  //
/////////////////////////////

/datum/sprite_accessory/hair/shorthairn
	name = "Curly Short"
	icon_state = "fhair_shorthairg"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/vlongfringen
	name = "Plain Long"
	icon_state = "fhair_vlongfringe"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/beehiven
	name = "Updo"
	icon_state = "fhair_beehive"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fhair_barmaidn
	name = "Maiden"
	icon_state = "fhair_barmaid"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fponyn
	name = "Tied Ponytail"
	icon_state = "fhair_longstraightponytail"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fmessn
	name = "Messy"
	icon_state = "fhair_messy"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/ftwinn
	name = "Tails"
	icon_state = "fhair_twintail"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fbunsn
	name = "Buns"
	icon_state = "fhair_doublebun"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fbobn
	name = "Bob"
	icon_state = "fhair_bob"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/ftomboyn
	name = "Tomboy"
	icon_state = "hair_runt"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/famazonn
	name = "Barbarian"
	icon_state = "fhair_amazon"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fbunsn
	name = "Loose Braid"
	icon_state = "fhair_tressshoulder"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fmysn
	name = "Mystery"
	icon_state = "fhair_himecut2"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fhomelyn
	name = "Homely"
	icon_state = "fhair_homely"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fqueenn
	name = "Queenly"
	icon_state = "fhair_bob2"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fpixn
	name = "Pixie"
	icon_state = "fhair_pixie"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/fariston
	name = "Aristocrat"
	icon_state = "fhair_majestic"
	gender = FEMALE
	specuse = list("standard", "fat")

/datum/sprite_accessory/hair/shorthairb
	name = "Curly"
	icon_state = "fhair_shorthairgb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/vlongfringeb
	name = "Stately"
	icon_state = "fhair_vlongfringeb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/beehiveb
	name = "Updo"
	icon_state = "fhair_beehiveb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fhair_barmaidb
	name = "Wench"
	icon_state = "fhair_barmaidb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fponyb
	name = "Tied High"
	icon_state = "fhair_longstraightponytailb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fmessb
	name = "Uncouth"
	icon_state = "fhair_messyb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/ftwinb
	name = "Twin Tails"
	icon_state = "fhair_twintailb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fbunsb
	name = "Double Buns"
	icon_state = "fhair_doublebunb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fbobb
	name = "Bobbed"
	icon_state = "fhair_bobb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/ftomboyb
	name = "Boyish"
	icon_state = "hair_runtb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/famazonb
	name = "Savage"
	icon_state = "fhair_amazonb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fbunsb
	name = "Braided"
	icon_state = "fhair_tressshoulderb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fmysb
	name = "Tidy"
	icon_state = "fhair_himecut2b"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fhomelyb
	name = "Mother"
	icon_state = "fhair_homelyb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fqueenb
	name = "Sovereign"
	icon_state = "fhair_bob2b"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/fpixb
	name = "Short"
	icon_state = "fhair_pixieb"
	gender = FEMALE
	specuse = list("bulky")

/datum/sprite_accessory/hair/faristob
	name = "Lady"
	icon_state = "fhair_majesticb"
	gender = FEMALE
	specuse = list("bulky")

/*
/datum/sprite_accessory/hair/felfhair_fatherless
	name = "Princessly"
	icon_state = "felfhair_fatherless"
	gender = FEMALE
	specuse = list("elf")*/

/////////////////////////////
// Facial Hair Definitions //
/////////////////////////////

/datum/sprite_accessory/facial_hair
	icon = 'icons/roguetown/mob/facial.dmi'
	gender = MALE

/datum/sprite_accessory/facial_hair/nonen
	name = "None"
	icon_state = ""
	gender = FEMALE
	specuse = ALL_RACES_LIST

/datum/sprite_accessory/facial_hair/shavedn
	name = "Nothing"
	icon_state = "facial_shaven"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/fiveoclockmn
	name = "Mustache"
	icon_state = "facial_5oclockmoustache"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/chinn
	name = "Clean Chin"
	icon_state = "facial_chin"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/pipen
	name = "Pipesmoker"
	icon_state = "facial_pipe"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/hermitn
	name = "Wise Hermit"
	icon_state = "facial_moonshiner"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/knightlyn
	name = "Knightly"
	icon_state = "facial_knightly"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/vikingn
	name = "Raider"
	icon_state = "facial_viking"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/vandyken
	name = "Rumata"
	icon_state = "facial_vandyke"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/burnsn
	name = "Sideburns"
	icon_state = "facial_burns"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/chopsn
	name = "Choppe"
	icon_state = "facial_muttonmus"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/fullbeardn
	name = "Full Beard"
	icon_state = "facial_fullbeard"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/cousinn
	name = "Fullest Beard"
	icon_state = "facial_brokenman"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/manlyn
	name = "Drinker"
	icon_state = "facial_manly"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/pickn
	name = "Pick"
	icon_state = "facial_longbeard"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/known
	name = "Knowledge"
	icon_state = "facial_wise"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/brewn
	name = "Brew"
	icon_state = "facial_moonshiner"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/rangern
	name = "Ranger"
	icon_state = "facial_dwarf"
	gender = MALE
	specuse = list("fat", "standard")

/datum/sprite_accessory/facial_hair/shavedb
	name = "None"
	icon_state = "facial_shavenb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/fiveoclockmb
	name = "Stache"
	icon_state = "facial_5oclockmoustacheb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/chinb
	name = "Clean"
	icon_state = "facial_chinb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/pipeb
	name = "Chin & Burns"
	icon_state = "facial_pipeb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/knightlyb
	name = "Upper Classman"
	icon_state = "facial_knightlyb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/vikingb
	name = "Helmsman"
	icon_state = "facial_vikingb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/vandykeb
	name = "Rumata"
	icon_state = "facial_vandykeb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/burnsb
	name = "Burns"
	icon_state = "facial_burnsb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/chopsb
	name = "Side Choppe"
	icon_state = "facial_muttonmusb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/fullbeardb
	name = "Big"
	icon_state = "facial_fullbeardb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/cousinb
	name = "Fullest"
	icon_state = "facial_brokenmanb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/manlyb
	name = "Full"
	icon_state = "facial_manlyb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/pickb
	name = "Long"
	icon_state = "facial_longbeardb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/knowb
	name = "Longer"
	icon_state = "facial_wiseb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/brewb
	name = "Long Chin"
	icon_state = "facial_moonshinerb"
	gender = MALE
	specuse = list("bulky")

/datum/sprite_accessory/facial_hair/rangerb
	name = "Braids"
	icon_state = "facial_dwarfb"
	gender = MALE
	specuse = list("bulky")

///////////////////////////
// Accessory Definitions //
///////////////////////////


/datum/sprite_accessory/accessories
	name = ""
	icon_state = null
	gender = NEUTER
	icon = 'icons/roguetown/mob/accessories.dmi'
	use_static = TRUE
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/accessories/nothing
	name = "Nothing"
	icon_state = "nothing"
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/accessories/earrings/sil
	name = "Earrings"
	icon_state = "earrings_sil"
	gender = FEMALE
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/accessories/earrings
	name = "Earrings (G)"
	icon_state = "earrings"
	gender = FEMALE
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/accessories/choker
	name = "Neckband"
	icon_state = "choker"
	gender = FEMALE
	specuse = list("standard", "bulky")

/datum/sprite_accessory/accessories/eyeglasses
	name = "Eyeglasses"
	icon_state = "eyeglasses"
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/accessories/eyepatch
	name = "Eyepatch (r)"
	icon_state = "eyepatch_r"
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/accessories/eyepatch/alt
	name = "Eyepatch (l)"
	icon_state = "eyepatch_l"
	specuse = list("fat", "standard", "bulky")

///////////////////////////
// Detail Definitions //
///////////////////////////


/datum/sprite_accessory/detail
	name = ""
	icon_state = null
	gender = NEUTER
	icon = 'icons/roguetown/mob/detail.dmi'
	use_static = TRUE
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/detail/nothing
	name = "Nothing"
	icon_state = "no tings"

/datum/sprite_accessory/detail/brows
	name = "Thick Eyebrows"
	icon_state = "brows"
	color_src = HAIR
	use_static = FALSE
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/detail/brows/dark
	name = "Dark Eyebrows"
	icon_state = "darkbrows"
	specuse = list("fat", "standard", "bulky")
	
/datum/sprite_accessory/detail/scar
	name = "Scar"
	icon_state = "scar"
	specuse = list("fat", "standard", "bulky")
	
/datum/sprite_accessory/detail/scart
	name = "Scar2"
	icon_state = "scar2"
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/detail/scarl
	name = "Scar3"
	icon_state = "scar3"
	specuse = list("fat", "standard", "bulky")

/datum/sprite_accessory/detail/burnface_r
	name = "Burns (r)"
	icon_state = "burnface_r"
	specuse = list("fat", "standard", "bulky")
	
/datum/sprite_accessory/detail/burnface_l
	name = "Burns (l)"
	icon_state = "burnface_l"
	specuse = list("fat", "standard", "bulky")
	
/datum/sprite_accessory/detail/deadeye_r
	name = "Dead Eye (r)"
	icon_state = "deadeye_r"
	specuse = list("fat", "standard", "bulky")
	
/datum/sprite_accessory/detail/deadeye_l
	name = "Dead Eye (l)"
	icon_state = "deadeye_l"
	specuse = list("fat", "standard", "bulky")
	
/datum/sprite_accessory/detail
	name = "Snail Eyes"
	gender = PLURAL
	icon_state = "snaileyes"

/datum/sprite_accessory/detail
	name = "Mandibles"
	gender = PLURAL
	icon_state = "mandibles"

/datum/sprite_accessory/detail
	name = "Tentacles"
	gender = PLURAL
	icon_state = "tentacles"

/datum/sprite_accessory/detail
	name = "Unnatural Growth (r)"
	icon_state = "unnaturalgrowth_r"

/datum/sprite_accessory/detail
	name = "Unnatural Growth (l)"
	icon_state = "unnaturalgrowth_l"

/datum/sprite_accessory/detail
	name = "Branch (r)"
	icon_state = "branch_r"

/datum/sprite_accessory/detail
	name = "Branch (l)"
	icon_state = "branch_l"

///////////////////////////
// Underwear Definitions //
///////////////////////////

/datum/sprite_accessory/underwear
	icon = 'icons/mob/clothing/underwear.dmi'
	use_static = FALSE
/*#ifdef MATURESERVER
/datum/sprite_accessory/underwear/nude
	name = "None"
	icon_state = null
	gender = NEUTER
	use_static = TRUE
	specuse = ALL_RACES_LIST
#else*/

/datum/sprite_accessory/underwear/female_leotard
	name = "Femleotard"
	icon_state = "female_leotard"
	gender = FEMALE
	specuse = ALL_RACES_LIST
	roundstart = FALSE

//#endif
////////////////////////////
// Undershirt Definitions //
////////////////////////////

/datum/sprite_accessory/undershirt
	icon = 'icons/mob/clothing/underwear.dmi'

/datum/sprite_accessory/undershirt/nude
	name = "Nude"
	icon_state = null
	gender = NEUTER

// please make sure they're sorted alphabetically and categorized
///////////////////////
// Socks Definitions //
///////////////////////

/datum/sprite_accessory/socks
	icon = 'icons/mob/clothing/underwear.dmi'

/datum/sprite_accessory/socks/nude
	name = "Nude"
	icon_state = null


//////////.//////////////////
// MutantParts Definitions //
/////////////////////////////

/datum/sprite_accessory/body_markings
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/body_markings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/body_markings/dtiger
	name = "Dark Tiger Body"
	icon_state = "dtiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/ltiger
	name = "Light Tiger Body"
	icon_state = "ltiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/lbelly
	name = "Light Belly"
	icon_state = "lbelly"
	gender_specific = 1

/datum/sprite_accessory/tails
	icon = 'icons/mob/mutant_bodyparts.dmi'
	gender = MALE
	specuse = list()

/datum/sprite_accessory/tails_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/tails/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails_animated/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails_animated/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/tails_animated/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/tails/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/tails_animated/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/tails/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/tails_animated/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/tails/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/tails_animated/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/snouts
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/snouts/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/snouts/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/snouts/sharplight
	name = "Sharp + Light"
	icon_state = "sharplight"

/datum/sprite_accessory/snouts/roundlight
	name = "Round + Light"
	icon_state = "roundlight"

/datum/sprite_accessory/horns
	icon = 'icons/mob/mutant_bodyparts.dmi'
	gender = MALE
	specuse = list()

/datum/sprite_accessory/ears
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/ears/none
	name = "None"
	icon_state = null

/datum/sprite_accessory/ears/elf
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "Elf"
	icon_state = "elf"
	specuse = list("elf")
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/ears/elfw
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "ElfW"
	icon_state = "elfw"
	specuse = list("elf", "tiefling") //tiebs use these
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/ears/elfh //halfelfs are humens techincally
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "ElfH"
	icon_state = "elf"
	specuse = list("human")
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/tails/human/tieb
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebTail"
	icon_state = "tiebtail"
	specuse = list("tiefling")
	gender = NEUTER
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/horns/tieb
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebHorns"
	icon_state = "tiebhorns"
	specuse = list("tiefling")
	gender = MALE
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/horns/tiebf
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebHornsF"
	icon_state = "tiebhornsf"
	specuse = list("tiefling")
	gender = FEMALE
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/ears/cat
	name = "Cat"
	icon_state = "cat"
	hasinner = 1
	color_src = HAIR
	specuse = list("cattan")

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/wings
	icon = 'icons/mob/clothing/wings.dmi'

/datum/sprite_accessory/wings_open
	icon = 'icons/mob/clothing/wings.dmi'

/datum/sprite_accessory/wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE

/datum/sprite_accessory/wings_open/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34

/datum/sprite_accessory/wings/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/frills
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/frills/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/frills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/spines
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/spines_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/spines/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines_animated/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines_animated/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/spines_animated/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/spines/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines_animated/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines_animated/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/spines_animated/aqautic
	name = "Aquatic"
	icon_state = "aqua"


/datum/sprite_accessory/legs 	//legs are a special case, they aren't actually sprite_accessories but are updated with them.
	icon = null					//These datums exist for selecting legs on preference, and little else

/datum/sprite_accessory/legs/none
	name = "Normal Legs"

/datum/sprite_accessory/legs/digitigrade_lizard
	name = "Digitigrade Legs"

/datum/sprite_accessory/caps
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = HAIR

/datum/sprite_accessory/caps/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/moth_wings
	icon = 'icons/mob/moth_wings.dmi'
	color_src = null

/datum/sprite_accessory/moth_wings/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/moth_wings/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/moth_wings/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/moth_wings/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/moth_wings/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/moth_wings/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/moth_wings/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/moth_wings/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/moth_wings/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/moth_wings/punished
	name = "Burnt Off"
	icon_state = "punished"
	locked = TRUE

/datum/sprite_accessory/moth_wings/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/moth_wings/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/moth_wings/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/moth_wings/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/moth_wings/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/moth_wings/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/moth_markings // the markings that moths can have. finally something other than the boring tan
	icon = 'icons/mob/moth_markings.dmi'
	color_src = null

/datum/sprite_accessory/moth_markings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/moth_markings/reddish
	name = "Reddish"
	icon_state = "reddish"

/datum/sprite_accessory/moth_markings/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/moth_markings/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/moth_markings/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/moth_markings/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/moth_markings/punished
	name = "Punished"
	icon_state = "punished"

/datum/sprite_accessory/moth_markings/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/moth_markings/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/moth_markings/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/moth_markings/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/moth_markings/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"


