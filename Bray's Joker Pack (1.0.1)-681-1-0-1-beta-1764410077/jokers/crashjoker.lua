
SMODS.Joker{ --.
    key = "crashjoker",
    config = {
        extra = {
            no = 0,
            var1 = 0,
            start_dissolve = 0
        }
    },
    loc_txt = {
        ['name'] = '.',
        ['text'] = {
            [1] = '.'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'sou' 
            or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    set_ability = function(self, card, initial)
        card:set_edition("e_negative", true)
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            return {
                func = function()
                    local destructable_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                            table.insert(destructable_jokers, joker)
                        end
                    end
                    local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                    
                    if target_joker then
                        target_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                    end
                    return true
                end,
                extra = {
                    func = function()
                        local destructable_jokers = {}
                        for i, joker in ipairs(G.jokers.cards) do
                            if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                table.insert(destructable_jokers, joker)
                            end
                        end
                        local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end,
                    colour = G.C.RED,
                    extra = {
                        func = function()
                            local destructable_jokers = {}
                            for i, joker in ipairs(G.jokers.cards) do
                                if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                    table.insert(destructable_jokers, joker)
                                end
                            end
                            local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                            
                            if target_joker then
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                            end
                            return true
                        end,
                        colour = G.C.RED,
                        extra = {
                            func = function()
                                local destructable_jokers = {}
                                for i, joker in ipairs(G.jokers.cards) do
                                    if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                        table.insert(destructable_jokers, joker)
                                    end
                                end
                                local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                                
                                if target_joker then
                                    target_joker.getting_sliced = true
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                            return true
                                        end
                                    }))
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                                end
                                return true
                            end,
                            colour = G.C.RED,
                            extra = {
                                func = function()
                                    local destructable_jokers = {}
                                    for i, joker in ipairs(G.jokers.cards) do
                                        if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                            table.insert(destructable_jokers, joker)
                                        end
                                    end
                                    local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                                    
                                    if target_joker then
                                        target_joker.getting_sliced = true
                                        G.E_MANAGER:add_event(Event({
                                            func = function()
                                                target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                                return true
                                            end
                                        }))
                                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                                    end
                                    return true
                                end,
                                colour = G.C.RED,
                                extra = {
                                    func = function()
                                        local destructable_jokers = {}
                                        for i, joker in ipairs(G.jokers.cards) do
                                            if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                                table.insert(destructable_jokers, joker)
                                            end
                                        end
                                        local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                                        
                                        if target_joker then
                                            target_joker.getting_sliced = true
                                            G.E_MANAGER:add_event(Event({
                                                func = function()
                                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                                    return true
                                                end
                                            }))
                                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                                        end
                                        return true
                                    end,
                                    colour = G.C.RED,
                                    extra = {
                                        func = function()
                                            local destructable_jokers = {}
                                            for i, joker in ipairs(G.jokers.cards) do
                                                if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                                    table.insert(destructable_jokers, joker)
                                                end
                                            end
                                            local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                                            
                                            if target_joker then
                                                target_joker.getting_sliced = true
                                                G.E_MANAGER:add_event(Event({
                                                    func = function()
                                                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                                        return true
                                                    end
                                                }))
                                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                                            end
                                            return true
                                        end,
                                        colour = G.C.RED,
                                        extra = {
                                            func = function()
                                                local destructable_jokers = {}
                                                for i, joker in ipairs(G.jokers.cards) do
                                                    if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                                        table.insert(destructable_jokers, joker)
                                                    end
                                                end
                                                local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                                                
                                                if target_joker then
                                                    target_joker.getting_sliced = true
                                                    G.E_MANAGER:add_event(Event({
                                                        func = function()
                                                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
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
                                }
                            }
                        }
                    }
                }
            }
        end
        if context.after and context.cardarea == G.jokers  then
            error("EasternFarmer Was Here")
        end
    end
}