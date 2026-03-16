-- Bloom Card
SMODS.Enhancement {
    key = 'bloom_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 0, y = 0 },
    config = { extra = { odds = 5 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_bloom_card')
        return { vars = { numerator, denominator } }
    end,
    --- If the chance happens the copies that card and gives it a random Edition OR Seal
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'SM_bloom_card', 1, card.ability.extra.odds) then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1

            local copy_card = copy_card(card, nil, nil, G.playing_card)
            copy_card:set_ability('c_base', nil, true)
            local randomVar = pseudorandom('SM_seed', 1, 15)

            if randomVar <= 6 then
                        
            else if randomVar <= 12 and randomVar > 6 then
                copy_card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'certificate_seal' }))
                else
                    copy_card:set_edition(poll_edition('wheel_of_fortune', nil, true, true, { 'e_polychrome', 'e_holo', 'e_foil' }))   
                end
            end
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            G.play:emplace(copy_card)
            copy_card.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    copy_card:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('k_SM_bloom'),
                colour = G.C.YELLOW,
                func = function() -- This is for timing purposes, it runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end,
}

-- Cyber Card
SMODS.Enhancement {
    key = 'cyber_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 1, y = 0 },
    config = { extra = {index_state = 'MID'} },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    --- Increase/decrease the rank of a cyber card only once per hand
    calculate = function(self, card, context)
        if context.after then
            card.ability.extra.index_state = 'MID'
        end
    end
}

-- Dirt Card
SMODS.Enhancement {
    key = 'dirt_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 2, y = 0 },
    config = { extra = { } },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SM_bloom_card
        return { vars = { } }
    end,
    --- Turns into a bloom card at the end of the round
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.hand and context.playing_card_end_of_round then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    play_sound('tarot1', 1)
                    card:juice_up(0.3, 0.5)
                    return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.05,
                    func = function()
                        card:flip()
                        play_sound('card1', 1, 1)
                        card:juice_up(0.3, 0.3)
                        return true    
                    end
                }))
                delay(0.1)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        -- apply the bloom enhancement
                        card:set_ability('m_SM_bloom_card')
                        return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            card:flip()
                            play_sound('tarot2', 1, 0.6)
                            card:juice_up(0.3, 0.3)
                            return true
                            end
                    }))
                    delay(0.1)  
            end
    end
}

-- Electro Card
SMODS.Enhancement {
    key = 'electro_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 3, y = 0 },
    config = { extra = { odds = 4, repetitions = 1 } },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_electro_card')
        return { vars = { numerator, denominator, card.ability.extra.repetitions } }
    end,
    --- This enhancement retriggers the adjacent cards 1 time
}

SMODS.current_mod.calculate = function(self, context)
    if context.repetition and (context.cardarea == G.play or context.cardarea == 'unscored') and SMODS.pseudorandom_probability(self, 'electro_card', 1, G.P_CENTERS.m_SM_electro_card.config.extra.odds) then
        local retriggers = {}
        local my_pos
        
        for i, v in ipairs(context.full_hand) do
            if v == context.other_card then
                my_pos = i
            end
            if SMODS.has_enhancement(v, 'm_SM_electro_card') then
                if i > 1 then
                    retriggers[i-1] = (retriggers[i-1] or 0) + 1
                end
                if i < #context.full_hand then
                    retriggers[i+1] = (retriggers[i+1] or 0) + 1
                end
            end
        end
        if retriggers[my_pos] then
            return {
                repetitions = retriggers[my_pos]
            }
        end
    end
end

-- Blue Chemical Card
SMODS.Enhancement {
    key = 'blue_chemical_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 4, y = 0 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = { chips = 0, Xchips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.Xchips } }
    end,
    --- Random chip effect when played
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            
            local randomVar = pseudorandom('SM_seed', 1, 10)

                if randomVar <= 5 then
                    card.ability.extra.chips = pseudorandom('SM_other_seed', 1, 100)
                    return {
                        chips = card.ability.extra.chips
                    }
                else
                    card.ability.extra.Xchips = pseudorandom('SM_other_extra_seed', 1, 5)
                    return {
                        xchips = card.ability.extra.Xchips
                    }
                end
        end
    end,
}

-- Red Chemical Card
SMODS.Enhancement {
    key = 'red_chemical_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 0, y = 1 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = { mult = 0, Xmult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.Xmult } }
    end,
    --- Random mult effect when played
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local randomVar = pseudorandom('SM_seed', 1, 10)

                if randomVar <= 5 then
                    card.ability.extra.mult = pseudorandom('SM_other_seed', 1, 15)
                    return {
                        mult = card.ability.extra.mult
                    }
                else
                    card.ability.extra.Xmult = pseudorandom('SM_other_extra_seed', 1, 5)
                    return {
                        xmult = card.ability.extra.Xmult
                    }
                end
        end
    end,
}

-- Green Chemical Card
SMODS.Enhancement {
    key = 'green_chemical_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 1, y = 1 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = { dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.Xdollars } }
    end,
    --- Random dollar effect when played
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra.dollars = pseudorandom('SM_other_seed', 1, 15)
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
}

-- Test Card
SMODS.Enhancement {
    key = 'test_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 0, y = 2 },
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    config = { extra = { consumables = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.consumables } }
    end,
    --- If destroyed, create 2 random negative Consumable cards
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for k, val in ipairs(context.removed) do
                if val==card then
                    local consumables_to_create = card.ability.extra.consumables
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + consumables_to_create
                    return{
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                        for i = 1, consumables_to_create do
                                            SMODS.add_card {
                                                set = 'Consumeables',
                                                area = G.consumeables,
                                                edition = 'e_negative'
                                            }
                                            G.GAME.consumeable_buffer = 0
                                        end
                                    return true
                                end)
                            }))
                        end
                    }
                end
            end
        end
    end
}

-- Purple Chemical Card
SMODS.Enhancement {
    key = 'purple_chemical_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 2, y = 1 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = { Xchips = 1, Xmult = 1, odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_purple_chemical_card')
        return { vars = { card.ability.extra.Xchips, card.ability.extra.Xmult, numerator, denominator } }
    end,
    --- Xchips and Xmult effect when played, gains a random value if held in hand
    --- 1 in 3 chance to be destroyed after being used
    calculate = function(self, card, context)
        
        if context.cardarea == G.hand and context.main_scoring then
            local randomChoice = pseudorandom('SM_seed', 1, 10)
            
            if randomChoice <= 5 then
                card.ability.extra.Xchips = card.ability.extra.Xchips + pseudorandom('SM_other_extra_seed', 0.5, 1.5)
                return {
                    message = localize('k_SM_upgrade_chips'),
                    colour = G.C.BLUE
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult + pseudorandom('SM_other_extra_seed', 0.5, 1.5)
                return {
                    message = localize('k_SM_upgrade_mult'),
                    colour = G.C.RED
                }
            end    
        end

        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and
            SMODS.pseudorandom_probability(card, 'SM_purple_chemical_card', 1, card.ability.extra.odds) then
            return {
                remove = true,
                message = localize('k_SM_dissolved'),
                colour = G.C.FILTER
            }
        end

        if context.main_scoring and context.cardarea == G.play then
            return {
                xchips = card.ability.extra.Xchips,
                xmult = card.ability.extra.Xmult
            }
        end
    end,
}

-- Cyan Chemical Card
SMODS.Enhancement {
    key = 'cyan_chemical_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 3, y = 1 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { percentage = 5, extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)

        local current_money = math.floor((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0))/2

        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_cyan_chemical_card')

        return { vars = { current_money, card.ability.percentage, numerator, denominator} }
    end,
    --- gives Xchips of the half of the current total money
    --- gives $ equal to the 5% of the total of chips of the current hand if held in hand
    --- 1 in 4 chance this card is destroyed at the end of round.
    calculate = function(self, card, context)

        if context.main_scoring and context.cardarea == G.hand then
            return {
                dollars = math.ceil((hand_chips or 0)*(card.ability.percentage/100))
            }
        end

        if context.end_of_round and context.game_over == false and context.cardarea == G.hand then
            if SMODS.pseudorandom_probability(card, 'SM_cyan_chemical_card', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- This replicates the food destruction effect
                        -- If you want a simpler way to destroy Jokers, you can do card:start_dissolve() for a dissolving animation
                        -- or just card:remove() for no animation
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_SM_dissolved'),
                    colour = G.C.FILTER
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end

        if context.main_scoring and context.cardarea == G.play then
            return {
                xchips = G.GAME.dollars/2
            }
        end
    end,
}

-- Brown Chemical Card
SMODS.Enhancement {
    key = 'brown_chemical_card',
    atlas = 'SciencefulEnhancements',
    pos = { x = 4, y = 1 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { percentage = 5, extra = { odds = 4, Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_brown_chemical_card')
        return { vars = { card.ability.extra.Xmult, card.ability.percentage, numerator, denominator } }
    end,
    --- drains Xmult of the equal to the 5% of the current $
    --- gives $ equal to the 5% of the total of mult of the current hand
    --- 1 in 4 chance this card resets after being played
    calculate = function(self, card, context)

        if context.main_scoring and context.cardarea == G.hand and context.after then
            return {
                dollars = math.ceil((mult or 0)*(card.ability.percentage/100))
            }
        end

        if context.cardarea == G.play and context.after then
            if SMODS.pseudorandom_probability(card, 'SM_brown_chemical_card', 1, card.ability.extra.odds) then
                card.ability.extra.Xmult = 1
                return {
                    message = localize('k_reset'),
                    sound = 'tarot1',
                    pitch = 1,
                    colour = G.C.attention
                }
            else
                return {
                }
            end
        end

        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra.Xmult = card.ability.extra.Xmult + G.GAME.dollars*(card.ability.percentage/100)
            return {
                xmult = card.ability.extra.Xmult,
                dollars = -math.floor(G.GAME.dollars*(card.ability.percentage/100))
            }
        end
    end,
}

local card_highlight = Card.highlight
function Card:highlight(highlighted)
    card_highlight(self, highlighted)
    if highlighted and self.config.center_key == 'm_SM_cyber_card' and self.area == G.hand and #G.hand.highlighted == 1 and not G.booster_pack then
        self.children.use_button = UIBox{
            definition = G.UIDEF.use_cyber_buttons(self), 
            config = {align = 'cl', offset = {x=0.5, y=0}, parent = self, id = 'SM_cyber_card'}
        }
    elseif self.area and #self.area.highlighted > 0 and not G.booster_pack then
        for _, card in ipairs(self.area.highlighted) do
            if card.config.center_key == 'm_SM_cyber_card' then
                card.children.use_button = #self.area.highlighted == 1 and UIBox{
                    definition = G.UIDEF.use_cyber_buttons(card), 
                    config = {align = 'cl', offset = {x=0.5, y=0}, parent = card}
                } or nil
            end
        end
        -- self.children.use_button = nil
    end
    if highlighted and self.children.use_button and self.children.use_button.config.id == 'SM_cyber_card' and self.config.center_key ~= 'm_SM_cyber_card' then
        self.children.use_button:remove()
    end
end

function G.UIDEF.use_cyber_buttons(card)
    local up = nil
    local down = nil

    up = {n=G.UIT.C, config={align = "cl"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cl", maxw = 1.25, padding = 0.1, r=0.08, minw = 0.9, minh = 0.7, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'increase_cyber', func = 'cyber_card_increase'}, nodes={
            {n=G.UIT.T, config={text = 'INC.', colour = G.C.UI.TEXT_LIGHT, scale = 0.36, shadow = true}}
        }}
    }}

    down = {n=G.UIT.C, config={align = "cl"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cl", maxw = 1.25, padding = 0.1, r=0.08, minw = 0.9, minh = 0.7, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'decrease_cyber', func = 'cyber_card_decrease'}, nodes={
            {n=G.UIT.T, config={text = 'DEC.', colour = G.C.UI.TEXT_LIGHT, scale = 0.36, shadow = true}}
        }}
    }}

    local t = {n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
            {n=G.UIT.R, config={align = 'cl'}, nodes={
                up
            }},
            {n=G.UIT.R, config={align = 'cl'}, nodes={
                down
            }},
        }},
    }}
    return t 
end

G.FUNCS.cyber_card_increase = function(e)
    if e.config.ref_table.ability.extra and type(e.config.ref_table.ability.extra) == 'table' and e.config.ref_table.ability.extra.index_state ~= 'UP' and e.config.ref_table.ability.extra.index_state ~= 'DOWN' then 
        e.config.colour = G.C.RED
        e.config.button = 'increase_cyber'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

---function that increases the rank of a cyber card
G.FUNCS.increase_cyber = function(e, mute, nosave)
    e.config.button = nil
    local card = e.config.ref_table
    local area = card.area
    local change = 1
    if card.ability.extra.index_state == 'DOWN' then change = 2 end
    card.ability.extra.index_state = 'UP'
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(G.hand.highlighted[i], 1))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
end

G.FUNCS.cyber_card_decrease = function(e)
    if e.config.ref_table.ability.extra and type(e.config.ref_table.ability.extra) == 'table' and e.config.ref_table.ability.extra.index_state ~= 'DOWN' and e.config.ref_table.ability.extra.index_state ~= 'UP' then 
        e.config.colour = G.C.RED
        e.config.button = 'decrease_cyber'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

---function that decreases the rank of a cyber card
G.FUNCS.decrease_cyber = function(e, mute, nosave)
    e.config.button = nil
    local card = e.config.ref_table
    local area = card.area
    local change = 1
    if card.ability.extra.index_state == 'UP' then change = 2 end
    card.ability.extra.index_state = 'DOWN'
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -1))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
end