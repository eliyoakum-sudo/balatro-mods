
SMODS.Joker{ --6 Ball
    key = "_6ball",
    config = {
        extra = {
            xmult0 = 6,
            odds = 6
        }
    },
    loc_txt = {
        ['name'] = '6 Ball',
        ['text'] = {
            [1] = 'Every {C:attention}6{} has a chance to',
            [2] = 'get {C:red}destroyed{},',
            [3] = 'but {C:rare}6x Mult{} when a {C:rare}6{} is',
            [4] = 'played and {C:attention}scores{}.'
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
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cueblatr_cueblatr_jokers"] = true, ["cueblatr_pool_ball"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cueblatr__6ball') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if context.other_card:get_id() == 6 then
                return {
                    Xmult = 6
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_404b6464', 1, card.ability.extra.odds, 'j_cueblatr__6ball', false) then
                            context.other_card.should_destroy = true
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            end
        end
    end
}