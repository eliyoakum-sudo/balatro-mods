
SMODS.Joker{ --Cardiac Joker
    key = "cardiacjoker",
    config = {
        extra = {
            odds = "3",
            repetitions0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Cardiac Joker',
        ['text'] = {
            [1] = '{C:green}1 in 3{} chance to retrigger',
            [2] = 'any played {C:hearts}heart{} suit cards.'
        },
        ['unlock'] = {
            [1] = 'Discard a heart flush.'
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
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_braysjokers_cardiacjoker') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                if SMODS.pseudorandom_probability(card, 'group_0_0837dec5', 1, card.ability.extra.odds, 'j_braysjokers_cardiacjoker', false) then
                    
                    return {repetitions = 1}
                end
            end
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "discard_custom" then
            local count = 0
            for i = 1, #args.cards do
                if args.cards[i]:is_suit("Hearts") then
                    count = count + 1
                end
            end
            if count == to_big(5) then
                return true
            end
        end
        return false
    end
}