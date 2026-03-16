
SMODS.Joker{ --R greeeeeeen and {C:blue}{}
key = "rgreeeeeeenandcblue",
config = {
    extra = {
    }
},
loc_txt = {
    ['name'] = 'R greeeeeeen and {C:blue}{}',
    ['text'] = {
        [1] = ''
    },
    ['unlock'] = {
        [1] = 'Unlocked by default.'
    }
},
pos = {
    x = 4,
    y = 0
},
display_size = {
    w = 71 * 1, 
    h = 95 * 1
},
cost = 5,
rarity = "test_rgb",
blueprint_compat = true,
eternal_compat = true,
perishable_compat = true,
unlocked = true,
discovered = true,
atlas = 'CustomJokers',
pools = { ["test_RGB"] = true },

calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play  then
        return {
            swap = true
        }
    end
end
}