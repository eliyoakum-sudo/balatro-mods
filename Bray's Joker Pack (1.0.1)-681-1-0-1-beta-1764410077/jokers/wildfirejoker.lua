
SMODS.Joker{ --Wildfire Joker
    key = "wildfirejoker",
    config = {
        extra = {
            odds = "4"
        }
    },
    loc_txt = {
        ['name'] = 'Wildfire Joker',
        ['text'] = {
            [1] = 'Each played card has',
            [2] = 'a {C:green}1 in 4{} chance',
            [3] = 'to be converted to a {C:red}Mult card{}.'
        },
        ['unlock'] = {
            [1] = ''
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_braysjokers_wildfirejoker') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_53c7c2a1', 1, card.ability.extra.odds, 'j_braysjokers_wildfirejoker', false) then
                    context.other_card:set_ability(G.P_CENTERS.m_mult)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
                end
            end
        end
    end
}