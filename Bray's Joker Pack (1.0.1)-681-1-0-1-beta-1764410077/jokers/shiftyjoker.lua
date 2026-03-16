
SMODS.Joker{ --Shifty Joker
    key = "shiftyjoker",
    config = {
        extra = {
            odds = "2",
            odds2 = "3",
            emult0 = 1.1,
            emult = 0.9
        }
    },
    loc_txt = {
        ['name'] = 'Shifty Joker',
        ['text'] = {
            [1] = '{C:green}1 in 2 {}chance to increase your {C:red}Mult',
            [2] = '{} by {X:mult,C:white}^1.1{} {C:red}Mult{} or 1 in 3 chance to',
            [3] = 'decrease your Mult by {X:mult,C:white}^0.9{} {C:red}Mult{} each card played.'
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
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_braysjokers_shiftyjoker')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_braysjokers_shiftyjoker')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_928f92f6', 1, card.ability.extra.odds, 'j_braysjokers_shiftyjoker', false) then
                    SMODS.calculate_effect({e_mult = 1.1}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_1_62f617dc', 1, card.ability.extra.odds2, 'j_braysjokers_shiftyjoker', false) then
                    SMODS.calculate_effect({e_mult = 0.9}, card)
                end
            end
        end
    end
}