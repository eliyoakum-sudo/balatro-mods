
SMODS.Joker{ --RGB
    key = "rgb",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'RGB',
        ['text'] = {
            [1] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
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
                swap = true
            }
        end
    end
}