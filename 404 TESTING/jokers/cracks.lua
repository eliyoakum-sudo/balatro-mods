
SMODS.Joker{ --cracks 
    key = "cracks",
    config = {
        extra = {
            odds = 100,
            xmult0 = 50
        }
    },
    loc_txt = {
        ['name'] = 'cracks ',
        ['text'] = {
            [1] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["test_mycustom_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 99, card.ability.extra.odds, 'j_test_cracks')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_test_cracks')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_3e81061d', 99, card.ability.extra.odds, 'j_test_cracks', false) then
                    error("EasternFarmer Was Here")
                    
                end
                if SMODS.pseudorandom_probability(card, 'group_1_da50263b', 1, card.ability.extra.odds, 'j_test_cracks', false) then
                    SMODS.calculate_effect({Xmult = 50}, card)
                end
            end
        end
    end
}