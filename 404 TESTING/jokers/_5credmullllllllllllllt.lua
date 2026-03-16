
SMODS.Joker{ --+5 {C:red}mullllllllllllllt{}
key = "_5credmullllllllllllllt",
config = {
    extra = {
        mult0 = 5
    }
},
loc_txt = {
    ['name'] = '+5 {C:red}mullllllllllllllt{}',
    ['text'] = {
        [1] = ''
    },
    ['unlock'] = {
        [1] = 'Unlocked by default.'
    }
},
pos = {
    x = 1,
    y = 0
},
display_size = {
    w = 71 * 1, 
    h = 95 * 1
},
cost = 4,
rarity = 2,
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
            mult = 5
        }
    end
end
}