SMODS.Rarity {
    key = "rgb",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.05,
    badge_colour = HEX('d0021b'),
    loc_txt = {
        name = "RGB"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "404",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('002611'),
    loc_txt = {
        name = "404"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}