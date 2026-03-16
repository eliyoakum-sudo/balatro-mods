
SMODS.Joker{ --{C:red}{} {C:green}{} {C:blue{}
key = "credcgreencblue",
config = {
    extra = {
    }
},
loc_txt = {
    ['name'] = '{C:red}{} {C:green}{} {C:blue{}',
    ['text'] = {
        [1] = ''
    },
    ['unlock'] = {
        [1] = 'Unlocked by default.'
    }
},
pos = {
    x = 2,
    y = 0
},
display_size = {
    w = 71 * 1, 
    h = 95 * 1
},
cost = 4,
rarity = "test_rgb",
blueprint_compat = true,
eternal_compat = true,
perishable_compat = true,
unlocked = true,
discovered = true,
atlas = 'CustomJokers',
pools = { ["test_RGB"] = true },

calculate = function(self, card, context)
    if context.after and context.cardarea == G.jokers  then
        return {
            balance = true
        }
    end
end
}