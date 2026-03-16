
SMODS.Joker{ --Frozen Joker
    key = "frozenjoker",
    config = {
        extra = {
            chips0 = 300,
            joker_slots0 = 2,
            joker_slots = 2,
            joker_slots2 = 2,
            joker_slots3 = 2,
            start_dissolve = 0,
            y = 0,
            no = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Frozen Joker',
        ['text'] = {
            [1] = 'Adds {C:blue}+300{} Chips to total score.',
            [2] = 'Turns into {C:red}Molten Joker{} after',
            [3] = '1 round.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = 300
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(2).." Joker Slot", colour = G.C.DARK_EDITION})
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 2
                    return true
                end,
                extra = {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Molten!", colour = G.C.RED})
                        end
                        return true
                    end,
                    colour = G.C.RED,
                    extra = {
                        func = function()
                            
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_braysjokers_moltenjoker' })
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(2).." Joker Slot", colour = G.C.RED})
                                G.jokers.config.card_limit = math.max(1, G.jokers.config.card_limit - 2)
                                return true
                            end,
                            colour = G.C.DARK_EDITION
                        }
                    }
                }
            }
        end
        if context.skip_blind  then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(2).." Joker Slot", colour = G.C.DARK_EDITION})
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 2
                    return true
                end,
                extra = {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Molten!", colour = G.C.RED})
                        end
                        return true
                    end,
                    colour = G.C.RED,
                    extra = {
                        func = function()
                            
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_braysjokers_moltenjoker' })
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(2).." Joker Slot", colour = G.C.RED})
                                G.jokers.config.card_limit = math.max(1, G.jokers.config.card_limit - 2)
                                return true
                            end,
                            colour = G.C.DARK_EDITION
                        }
                    }
                }
            }
        end
    end
}