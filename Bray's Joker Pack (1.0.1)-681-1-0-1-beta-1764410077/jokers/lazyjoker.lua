
SMODS.Joker{ --Lazy Joker
    key = "lazyjoker",
    config = {
        extra = {
            dollars0 = 1,
            sell_value0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Lazy Joker',
        ['text'] = {
            [1] = 'A {C:blue}custom{} joker with {C:red}unique{} effects.',
            [2] = '(Gains 3$ in sell value {X:blue,C:white}every{}{X:blue,C:white}hand{},',
            [3] = 'but sets money to 1$)'
        },
        ['unlock'] = {
            [1] = 'Play 7 or less chips in one hand.'
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
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            local target_card = G.jokers.cards[my_pos]
            target_card.ability.extra_value = (card.ability.extra_value or 0) + 3
            target_card:set_cost()
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = 1
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to $"..tostring(1), colour = G.C.MONEY})
                    return true
                end,
                extra = {
                    message = "+"..tostring(3).." Sell Value",
                    colour = G.C.MONEY
                }
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips <= to_big(7)
        end
        return false
    end
}