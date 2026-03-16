SMODS.ConsumableType{
    key = "Experimentum",
    primary_colour = HEX("dab772"),
    secondary_colour = HEX("a58547"),
    collection_rows = { 4, 5 },
    shop_rate = 3,
    default = "c_SM_soil_genesis"
}

SMODS.UndiscoveredSprite{
    key = "Experimentum",
    atlas = "UndiscoveredExperimentum",
    pos = { x=0, y=0 }
}

-- Soil Genesis
SMODS.Consumable {
    key = 'soil_genesis',
    set = 'Experimentum',
    atlas = 'SciencefulExperimentum',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2, mod_conv = 'm_SM_dirt_card' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

-- Technology
SMODS.Consumable {
    key = 'technology',
    set = 'Experimentum',
    atlas = 'SciencefulExperimentum',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_SM_cyber_card' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

-- Charge
SMODS.Consumable {
    key = 'charge',
    set = 'Experimentum',
    atlas = 'SciencefulExperimentum',
    pos = { x = 2, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_SM_electro_card' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

-- Substance
SMODS.Consumable {
    key = 'substance',
    set = 'Experimentum',
    atlas = 'SciencefulExperimentum',
    pos = { x = 3, y = 0 },
    config = { max_highlighted = 1, min_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SM_blue_chemical_card
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SM_red_chemical_card
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SM_green_chemical_card
        return { vars = { card.ability.max_highlighted } }
    end,

    use = function(self, card, area, copier)
        
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
                    local randomEnhancement
                    randomEnhancement = SMODS.poll_enhancement( { type_key = "SM_seed", guaranteed = true, options = { "m_SM_blue_chemical_card", "m_SM_red_chemical_card", "m_SM_green_chemical_card" } } )
                    G.hand.highlighted[i]:set_ability(randomEnhancement)
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
    end,
    can_use = function(self, card)

        local is_chemical = true
        if #G.hand.highlighted == 1 then
            for _, playing_card in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(playing_card, "m_SM_blue_chemical_card")
                or SMODS.has_enhancement(playing_card, "m_SM_red_chemical_card")
                or SMODS.has_enhancement(playing_card, "m_SM_green_chemical_card") then
                    is_chemical = false
                    break
                end
            end
            return is_chemical
        end
    end
}

-- Check
SMODS.Consumable {
    key = 'check',
    set = 'Experimentum',
    atlas = 'SciencefulExperimentum',
    pos = { x = 4, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_SM_test_card' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

-- Traits
SMODS.Consumable {
    key = 'traits',
    set = 'Experimentum',
    atlas = 'SciencefulExperimentum',
    pos = { x = 5, y = 0 },
    config = { max_highlighted = 3, min_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
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
        local leftmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x < leftmost.T.x then
                leftmost = G.hand.highlighted[i]
            end
        end
        local leftmostEnhancement = leftmost.config.center.key
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= leftmost then
                        G.hand.highlighted[i]:set_ability(leftmostEnhancement)
                    end
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
    end,
}

-- Mix
SMODS.Consumable {
    key = 'mix',
    set = 'Experimentum',
    atlas = 'SciencefulExperimentum',
    pos = { x = 0, y = 1 },
    config = { max_highlighted = 2, min_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
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
        local leftmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x < leftmost.T.x then
                leftmost = G.hand.highlighted[i]
            end
        end
        local rightmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
            end
        end
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= leftmost then
                        SMODS.destroy_cards(G.hand.highlighted[i])
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= rightmost then
                        if leftmost.config.center == G.P_CENTERS.m_SM_blue_chemical_card and rightmost.config.center == G.P_CENTERS.m_SM_red_chemical_card
                        or leftmost.config.center == G.P_CENTERS.m_SM_red_chemical_card and rightmost.config.center == G.P_CENTERS.m_SM_blue_chemical_card then
                            
                            G.hand.highlighted[i]:set_ability('m_SM_purple_chemical_card')

                            elseif leftmost.config.center == G.P_CENTERS.m_SM_blue_chemical_card and rightmost.config.center == G.P_CENTERS.m_SM_green_chemical_card
                        or leftmost.config.center == G.P_CENTERS.m_SM_green_chemical_card and rightmost.config.center == G.P_CENTERS.m_SM_blue_chemical_card then

                            G.hand.highlighted[i]:set_ability('m_SM_cyan_chemical_card')

                            elseif leftmost.config.center == G.P_CENTERS.m_SM_red_chemical_card and rightmost.config.center == G.P_CENTERS.m_SM_green_chemical_card
                        or leftmost.config.center == G.P_CENTERS.m_SM_green_chemical_card and rightmost.config.center == G.P_CENTERS.m_SM_red_chemical_card then

                            G.hand.highlighted[i]:set_ability('m_SM_brown_chemical_card')
                            
                        end
                    end
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
    end,    
    can_use = function(self, card)
        if #G.hand.highlighted == 2 then
            local chemical_list = {}
            for _, playing_card in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(playing_card, "m_SM_red_chemical_card")
                or SMODS.has_enhancement(playing_card, "m_SM_blue_chemical_card")
                or SMODS.has_enhancement(playing_card, "m_SM_green_chemical_card") then
                    table.insert(chemical_list, playing_card.config.center_key)
                end
            end
        return #chemical_list == 2 and chemical_list[1] ~= chemical_list[2]
    end
end
}