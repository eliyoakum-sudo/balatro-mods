SMODS.Rarity {
    key = "orange",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.0001,
    badge_colour = HEX('f5a623'),
    loc_txt = {
        name = "Orange"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "unified",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.025,
    badge_colour = HEX('f8e71c'),
    loc_txt = {
        name = "Unified"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}