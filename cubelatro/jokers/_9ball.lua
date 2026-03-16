
SMODS.Joker{ --9 Ball
    key = "_9ball",
    config = {
        extra = {
            odds = 9,
            mult0 = 25
        }
    },
    loc_txt = {
        ['name'] = '9 Ball',
        ['text'] = {
            [1] = '{C:attention}1 in 9{} chance to add',
            [2] = '{C:red}25 Mult{} per card {C:blue}scored{}.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
    pools = { ["cueblatr_cueblatr_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cueblatr__9ball') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_aa4a0161', 1, card.ability.extra.odds, 'j_cueblatr__9ball', false) then
                    SMODS.calculate_effect({mult = 25}, card)
                end
            end
        end
    end
}