
SMODS.Joker{ --Noob Joker
    key = "noobjoker",
    config = {
        extra = {
            roundsleft = 5,
            chips0 = 30,
            ignore = 0,
            explode = 0,
            n = 0,
            no = 0
        }
    },
    loc_txt = {
        ['name'] = 'Noob Joker',
        ['text'] = {
            [1] = 'Gives 30 {C:blue}Chips{} per card played.',
            [2] = 'Complete 5 rounds to',
            [3] = 'obtain {C:diamonds}Mad Noob Joker{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.roundsleft}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            return {
                chips = 30
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if to_big((card.ability.extra.roundsleft or 0)) <= to_big(0) then
                return {
                    func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_braysjokers_madnoobjoker' })
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
                    extra = {
                        func = function()
                            local target_joker = card
                            
                            if target_joker then
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:explode({G.C.RED}, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                            end
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            else
                return {
                    func = function()
                        card.ability.extra.roundsleft = math.max(0, (card.ability.extra.roundsleft) - 1)
                        return true
                    end
                }
            end
        end
    end
}