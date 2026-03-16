
SMODS.Joker{ --+5 {C:blue}chippppppppp{}
key = "+5chips",
config = {
    extra = {
        chips0 = 5
    }
},
loc_txt = {
    ['name'] = '+5 {C:blue}chippppppppp{}',
    ['text'] = {
        [1] = ''
    },
    ['unlock'] = {
        [1] = 'Unlocked by default.'
    }
},
pos = {
    x = 0,
    y = 0
},
display_size = {
    w = 71 * 1, 
    h = 95 * 1
},
cost = 4,
rarity = 1,
blueprint_compat = true,
eternal_compat = true,
perishable_compat = true,
unlocked = true,
discovered = true,
atlas = 'CustomJokers',
pools = { ["test_mycustom_jokers"] = true },

calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play  then
        return {
            chips = 5
        }
    end
end
}