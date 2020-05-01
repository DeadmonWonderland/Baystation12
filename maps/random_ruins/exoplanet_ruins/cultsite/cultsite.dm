/datum/map_template/ruin/exoplanet/monolith
	name = "Cult Temple"
	id = "cult_temple"
	description = "A small temple."
	suffixes = list("cultsite/cultsite.dmm")
	cost = 1
	template_flags = TEMPLATE_FLAG_NO_RUINS
	ruin_tags = RUIN_ALIEN

/obj/structure/strangealtar
	name = "Strange Altar"
	desc = "A strange altar covered in blood.. The symbols '<font face='Mabe'>DWNbTX</font>' are engraved on the base."
	icon = 'icons/obj/monolith.dmi'
	layer = ABOVE_HUMAN_LAYER
	density = 1
	anchored = 1
	var/active = 0


/obj/structure/strangealtar/attack_hand(mob/user)
	visible_message("[user] touches \the [src].")
	if(GLOB.using_map.use_overmap && istype(user,/mob/living/carbon/human))
		var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
		if(istype(E))
			var/mob/living/carbon/human/H = user
			if(!H.isSynthetic())
				playsound(src, 'sound/effects/zapbeep.ogg', 100, 1)
				active = 1
				update_icon()
				if(prob(70))
					to_chat(H, "<span class='notice'>As you touch \the [src], you suddenly get a vivid image - [E.get_engravings()]</span>")
				else
					to_chat(H, "<span class='warning'>An overwhelming stream of information invades your mind!</span>")
					var/vision = ""
					for(var/i = 1 to 10)
						vision += pick(E.actors) + " " + pick("killing","dying","gored","expiring","exploding","mauled","burning","flayed","in agony") + ". "
					to_chat(H, "<span class='danger'><font size=2>[uppertext(vision)]</font></span>")
					H.Paralyse(2)
					H.hallucination(20, 100)
				return
	to_chat(user, "<span class='notice'>\The [src] is still.</span>")
	return ..()