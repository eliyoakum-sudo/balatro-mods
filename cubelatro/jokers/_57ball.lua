
SMODS.Joker{ --57 Ball
    key = "_57ball",
    config = {
        extra = {
            sell_value0 = 57
        }
    },
    loc_txt = {
        ['name'] = '57 Ball',
        ['text'] = {
            [1] = 'Gains {C:money}$57{} per {C:attention}Boss Blind{} beat',
            [2] = 'with this {C:red}Joker{} in your inventory'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 3,
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
    
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            return {
                func = function()local my_pos = nil
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then
                            my_pos = i
                            break
                        end
                    end
                    local target_card = G.jokers.cards[my_pos]
                    target_card.ability.extra_value = (card.ability.extra_value or 0) + 57
                    target_card:set_cost()
                    return true
                end,
                message = "+"..tostring(57).." Sell Value"
            }
        end
    end
}