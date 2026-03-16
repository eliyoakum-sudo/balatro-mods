
SMODS.Joker{ --Epic Joker
    key = "epicjoker",
    config = {
        extra = {
            joker_slots0 = 1,
            joker_slots = 1,
            braysjokers_jokers = 0,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Epic Joker',
        ['text'] = {
            [1] = 'Randomly selects a joker from {C:gold}Bray\'s Joker Pack{}',
            [2] = 'once you sell this joker. :D'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
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
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.selling_self  then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Joker Slot", colour = G.C.DARK_EDITION})
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                    return true
                end,
                extra = {
                    func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'braysjokers_braysjokers_jokers' })
                                    if joker_card then
                                        
                                        
                                    end
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end,
                    colour = G.C.BLUE,
                    extra = {
                        func = function()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(1).." Joker Slot", colour = G.C.RED})
                            G.jokers.config.card_limit = math.max(1, G.jokers.config.card_limit - 1)
                            return true
                        end,
                        colour = G.C.DARK_EDITION
                    }
                }
            }
        end
    end
}