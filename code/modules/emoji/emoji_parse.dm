// Shared statics to avoid re-evaluating on every call
var/static/emoji_icon_file = icon('icons/emoji.dmi')
var/static/list/emoji_states = icon_states(emoji_icon_file)

/// Replaces :emoji_name: tokens in [text] with their inline icon tags.
/proc/emoji_parse(text)
    if(!text)
        return ""

    var/parsed = ""
    var/pos = 1

    while(TRUE)
        var/colon1 = findtext(text, ":", pos)
        if(!colon1)
            // No more colons — append remainder and stop
            parsed += copytext(text, pos)
            break

        // Append everything before this colon
        parsed += copytext(text, pos, colon1)

        var/colon2 = findtext(text, ":", colon1 + 1)
        if(!colon2)
            // Lone colon at end of string — append it and stop
            parsed += copytext(text, colon1)
            break

        var/name = lowertext(copytext(text, colon1 + 1, colon2))
        if(name in emoji_states)
            parsed += "\icon[icon(emoji_icon_file, name)]"
            pos = colon2 + 1
        else
            // Not a valid emoji — treat opening colon as literal text
            parsed += ":"
            pos = colon1 + 1

    return parsed

/// Returns only the valid :emoji_name: tokens from [text], stripping all other content.
/proc/emoji_sanitize(text)
    if(!text)
        return ""

    var/final = ""
    var/pos = 1

    while(TRUE)
        var/colon1 = findtext(text, ":", pos)
        if(!colon1)
            break

        var/colon2 = findtext(text, ":", colon1 + 1)
        if(!colon2)
            break

        var/name = lowertext(copytext(text, colon1 + 1, colon2))
        if(name in emoji_states)
            final += ":[name]:"
        pos = colon2 + 1

    return final