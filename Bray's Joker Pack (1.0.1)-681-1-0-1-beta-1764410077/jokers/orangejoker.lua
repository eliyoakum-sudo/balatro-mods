
SMODS.Joker{ --Orange Joker
    key = "orangejoker",
    config = {
        extra = {
            text = 0,
            n = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'Orange Joker',
        ['text'] = {
            [1] = 'He\'s {X:attention,C:white}orange{} for an {C:attention}amazing{} reason!',
            [2] = '(Swaps {C:blue}Chips{} and {C:red}Mult{} each',
            [3] = '{C:diamonds}Diamond{} card played.)'
        },
        ['unlock'] = {
            [1] = 'Win 5 runs.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_secretjokers"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Diamonds") then
                return {
                    message = "Orange!",
                    extra = {
                        swap = true,
                        colour = G.C.CHIPS
                    }
                }
            end
        end
        if context.selling_self  then
            return {
                func = function()
                    
                    for i = 1, 2 do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                end
                                
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Tarot', edition = 'e_negative', key = 'c_star'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                    
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "win" then
            local count = 0
            return 
        end
        return false
    end
}