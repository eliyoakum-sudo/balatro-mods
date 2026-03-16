
SMODS.Joker{ --Billionare Joker
    key = "billionarejoker",
    config = {
        extra = {
            dollars0 = 5
        }
    },
    loc_txt = {
        ['name'] = 'Billionare Joker',
        ['text'] = {
            [1] = 'Gives {C:gold}5 Dollars{} everytime you skip a {C:attention}blind.{}'
        },
        ['unlock'] = {
            [1] = 'Win a run without playing a High Card.'
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
        if context.skip_blind  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + 5
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(5), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "win" then
            local count = 0
            return G.GAME.hands["High Card"].played == 0
        end
        return false
    end
}