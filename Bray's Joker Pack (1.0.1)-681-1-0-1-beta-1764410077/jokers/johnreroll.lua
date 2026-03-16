
SMODS.Joker{ --John Reroll
    key = "johnreroll",
    config = {
        extra = {
            dollars0 = 999999999999999
        }
    },
    loc_txt = {
        ['name'] = 'John Reroll',
        ['text'] = {
            [1] = '{E:1}John{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
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
    pools = { ["braysjokers_braysjokers_secretjokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' 
            or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    set_ability = function(self, card, initial)
        card:set_edition("e_negative", true)
    end,
    
    calculate = function(self, card, context)
        if context.starting_shop  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + 999999999999999
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Dollars", colour = G.C.MONEY})
                    return true
                end
            }
        end
    end
}