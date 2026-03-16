
SMODS.Joker{ --Electro Chad
    key = "electrochad",
    config = {
        extra = {
            repetitions0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Electro Chad',
        ['text'] = {
            [1] = 'Retrigger {C:attention}last{} played card used in scoring {C:attention}2{} additional times.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
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
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                return {
                    repetitions = 2,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}